package com.vseeheat.collector;

import android.content.ContentValues;
import android.content.Context;
import android.content.SharedPreferences;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.provider.MediaStore;
import android.security.keystore.KeyGenParameterSpec;
import android.security.keystore.KeyProperties;
import android.util.Base64;

import org.json.JSONObject;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.KeyStore;
import java.security.MessageDigest;
import java.security.PrivateKey;
import java.security.SecureRandom;
import java.security.Signature;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.Arrays;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;

/** One owner key, app-private local copy, and encrypted recovery file in Downloads. */
final class OwnerSigningKeys {
    private static final String ALIAS = "heat_live_owner_key_wrap_v1";
    private static final String PREFS = "owner_signing_key";
    private static final String PACKAGE = "com.torre.heatlive.v6profile";
    private static final String BACKUP_PREFIX = "Heat-Live-Owner-Key-Backup-";
    private static final int KDF_ITERATIONS = 220_000;
    private static final SecureRandom RANDOM = new SecureRandom();

    private OwnerSigningKeys() {}

    static Material load(Context context) throws Exception {
        SharedPreferences prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE);
        String certText = prefs.getString("certificate", null);
        String sealedText = prefs.getString("sealed_key", null);
        if (certText == null && sealedText == null) return null;
        if (certText == null || sealedText == null) throw new IllegalStateException();
        X509Certificate cert = certificate(decode(certText));
        SecretKey wrappingKey = wrappingKey(false);
        if (wrappingKey == null) throw new IllegalStateException();
        byte[] packed = decode(sealedText);
        if (packed.length < 29 || (packed[0] & 0xff) != 12) throw new IllegalStateException();
        byte[] iv = Arrays.copyOfRange(packed, 1, 13);
        Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
        cipher.init(Cipher.DECRYPT_MODE, wrappingKey, new GCMParameterSpec(128, iv));
        cipher.updateAAD(cert.getEncoded());
        byte[] plain = cipher.doFinal(packed, 13, packed.length - 13);
        try {
            Material material = new Material(privateKey(plain), cert);
            verifyPair(material);
            return material;
        } finally {
            Arrays.fill(plain, (byte) 0);
        }
    }

    static Material createLocal(Context context) throws Exception {
        if (load(context) != null) throw new IllegalStateException();
        KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
        generator.initialize(3072, RANDOM);
        KeyPair pair = generator.generateKeyPair();
        if (pair.getPrivate().getEncoded() == null) throw new IllegalStateException();
        Material material = new Material(pair.getPrivate(), OwnerCertificate.create(pair));
        verifyPair(material);
        saveLocal(context, material);
        return material;
    }

    static BackupResult createAndBackup(Context context) throws Exception {
        createLocal(context);
        return exportBackup(context);
    }

    static BackupResult exportBackup(Context context) throws Exception {
        Material material = load(context);
        if (material == null) throw new IllegalStateException();
        byte[] recoveryBytes = new byte[16];
        RANDOM.nextBytes(recoveryBytes);
        String phrase = groupBase32(recoveryBytes);
        byte[] salt = new byte[16];
        byte[] iv = new byte[12];
        RANDOM.nextBytes(salt);
        RANDOM.nextBytes(iv);
        byte[] cert = material.certificate.getEncoded();
        byte[] keyBytes = material.privateKey.getEncoded();
        if (keyBytes == null) throw new IllegalStateException();
        Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
        cipher.init(Cipher.ENCRYPT_MODE, derive(phrase, salt), new GCMParameterSpec(128, iv));
        cipher.updateAAD(backupAad(cert));
        byte[] encrypted;
        try {
            encrypted = cipher.doFinal(keyBytes);
        } finally {
            Arrays.fill(keyBytes, (byte) 0);
        }
        JSONObject backup = new JSONObject();
        backup.put("format", 1);
        backup.put("package", PACKAGE);
        backup.put("kdf", "PBKDF2-HMAC-SHA256");
        backup.put("iterations", KDF_ITERATIONS);
        backup.put("certificate", encode(cert));
        backup.put("salt", encode(salt));
        backup.put("iv", encode(iv));
        backup.put("encryptedKey", encode(encrypted));
        String name = BACKUP_PREFIX + System.currentTimeMillis() + ".vseebak";
        Uri location = writeDownloads(context, name,
                backup.toString().getBytes(StandardCharsets.UTF_8));
        if (!context.getSharedPreferences(PREFS, Context.MODE_PRIVATE).edit()
                .putBoolean("backup_completed", true)
                .putBoolean("backup_acknowledged", false).commit()) {
            throw new IllegalStateException();
        }
        return new BackupResult(location, phrase, name);
    }

    static boolean backupCompleted(Context context) {
        return context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
                .getBoolean("backup_completed", false);
    }

    static boolean backupAcknowledged(Context context) {
        SharedPreferences prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE);
        return prefs.getBoolean("backup_completed", false)
                && prefs.getBoolean("backup_acknowledged", false);
    }

    static void acknowledgeBackup(Context context) throws Exception {
        if (!backupCompleted(context) || load(context) == null
                || !context.getSharedPreferences(PREFS, Context.MODE_PRIVATE).edit()
                        .putBoolean("backup_acknowledged", true).commit()) {
            throw new IllegalStateException();
        }
    }

    static void restore(Context context, Uri backupUri, String recoveryPhrase) throws Exception {
        boolean usableLocal = false;
        try {
            usableLocal = load(context) != null;
        } catch (Exception ignored) { /* allow owner backup to replace broken local storage */ }
        if (usableLocal) throw new IllegalStateException();
        byte[] raw;
        try (InputStream input = context.getContentResolver().openInputStream(backupUri)) {
            if (input == null) throw new IllegalStateException();
            raw = readBounded(input, 16 * 1024);
        }
        JSONObject backup = new JSONObject(new String(raw, StandardCharsets.UTF_8));
        if (backup.getInt("format") != 1
                || !PACKAGE.equals(backup.getString("package"))
                || !"PBKDF2-HMAC-SHA256".equals(backup.getString("kdf"))
                || backup.getInt("iterations") != KDF_ITERATIONS) {
            throw new IllegalStateException();
        }
        byte[] certBytes = decode(backup.getString("certificate"));
        byte[] salt = decode(backup.getString("salt"));
        byte[] iv = decode(backup.getString("iv"));
        byte[] encrypted = decode(backup.getString("encryptedKey"));
        if (salt.length != 16 || iv.length != 12 || encrypted.length > 8192) {
            throw new IllegalStateException();
        }
        Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
        cipher.init(Cipher.DECRYPT_MODE, derive(recoveryPhrase, salt),
                new GCMParameterSpec(128, iv));
        cipher.updateAAD(backupAad(certBytes));
        byte[] plain = cipher.doFinal(encrypted);
        try {
            Material material = new Material(privateKey(plain), certificate(certBytes));
            verifyPair(material);
            saveLocal(context, material);
        } finally {
            Arrays.fill(plain, (byte) 0);
        }
        if (!context.getSharedPreferences(PREFS, Context.MODE_PRIVATE).edit()
                .putBoolean("backup_completed", true)
                .putBoolean("backup_acknowledged", true).commit()) {
            throw new IllegalStateException();
        }
    }

    private static void saveLocal(Context context, Material material) throws Exception {
        byte[] cert = material.certificate.getEncoded();
        byte[] plain = material.privateKey.getEncoded();
        if (plain == null) throw new IllegalStateException();
        Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
        cipher.init(Cipher.ENCRYPT_MODE, wrappingKey(true));
        cipher.updateAAD(cert);
        byte[] encrypted = cipher.doFinal(plain);
        Arrays.fill(plain, (byte) 0);
        byte[] iv = cipher.getIV();
        if (iv == null || iv.length != 12) throw new IllegalStateException();
        byte[] packed = new byte[1 + iv.length + encrypted.length];
        packed[0] = 12;
        System.arraycopy(iv, 0, packed, 1, iv.length);
        System.arraycopy(encrypted, 0, packed, 13, encrypted.length);
        if (!context.getSharedPreferences(PREFS, Context.MODE_PRIVATE).edit()
                .putString("certificate", encode(cert))
                .putString("sealed_key", encode(packed))
                .putBoolean("backup_completed", false)
                .putBoolean("backup_acknowledged", false).commit()) {
            throw new IllegalStateException();
        }
    }

    private static SecretKey wrappingKey(boolean create) throws Exception {
        KeyStore store = KeyStore.getInstance("AndroidKeyStore");
        store.load(null);
        KeyStore.Entry entry = store.getEntry(ALIAS, null);
        if (entry instanceof KeyStore.SecretKeyEntry) {
            return ((KeyStore.SecretKeyEntry) entry).getSecretKey();
        }
        if (entry != null || !create) return null;
        KeyGenerator generator = KeyGenerator.getInstance("AES", "AndroidKeyStore");
        generator.init(new KeyGenParameterSpec.Builder(ALIAS,
                KeyProperties.PURPOSE_ENCRYPT | KeyProperties.PURPOSE_DECRYPT)
                .setBlockModes(KeyProperties.BLOCK_MODE_GCM)
                .setEncryptionPaddings(KeyProperties.ENCRYPTION_PADDING_NONE)
                .setKeySize(256).build());
        return generator.generateKey();
    }

    private static SecretKey derive(String phrase, byte[] salt) throws Exception {
        String normalized = phrase.replace("-", "").replace(" ", "")
                .toUpperCase(java.util.Locale.US);
        if (!normalized.matches("[A-Z2-7]{26}")) throw new IllegalArgumentException();
        char[] password = normalized.toCharArray();
        PBEKeySpec spec = new PBEKeySpec(password, salt,
                KDF_ITERATIONS, 256);
        try {
            byte[] derived = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256")
                    .generateSecret(spec).getEncoded();
            SecretKey key = new SecretKeySpec(derived, "AES");
            Arrays.fill(derived, (byte) 0);
            return key;
        } finally {
            spec.clearPassword();
            Arrays.fill(password, '\0');
        }
    }

    private static byte[] backupAad(byte[] certificate) throws Exception {
        ByteArrayOutputStream value = new ByteArrayOutputStream();
        value.write("VSeeHeatOwnerKeyBackup|1|".getBytes(StandardCharsets.US_ASCII));
        value.write(PACKAGE.getBytes(StandardCharsets.US_ASCII));
        value.write('|');
        value.write(MessageDigest.getInstance("SHA-256").digest(certificate));
        return value.toByteArray();
    }

    private static String groupBase32(byte[] data) {
        final char[] alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567".toCharArray();
        StringBuilder value = new StringBuilder(31);
        int buffer = 0;
        int bits = 0;
        for (byte item : data) {
            buffer = (buffer << 8) | (item & 0xff);
            bits += 8;
            while (bits >= 5) {
                value.append(alphabet[(buffer >>> (bits - 5)) & 31]);
                bits -= 5;
            }
        }
        if (bits > 0) value.append(alphabet[(buffer << (5 - bits)) & 31]);
        String raw = value.toString();
        StringBuilder grouped = new StringBuilder(32);
        for (int index = 0; index < raw.length(); index++) {
            if (index > 0 && index % 5 == 0) grouped.append('-');
            grouped.append(raw.charAt(index));
        }
        return grouped.toString();
    }

    private static Uri writeDownloads(Context context, String name, byte[] data)
            throws Exception {
        if (Build.VERSION.SDK_INT < 29) throw new IllegalStateException();
        ContentValues values = new ContentValues();
        values.put(MediaStore.MediaColumns.DISPLAY_NAME, name);
        values.put(MediaStore.MediaColumns.MIME_TYPE, "application/octet-stream");
        values.put(MediaStore.MediaColumns.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS);
        values.put(MediaStore.MediaColumns.IS_PENDING, 1);
        Uri uri = context.getContentResolver().insert(
                MediaStore.Downloads.EXTERNAL_CONTENT_URI, values);
        if (uri == null) throw new IllegalStateException();
        try {
            try (OutputStream output = context.getContentResolver().openOutputStream(uri, "w")) {
                if (output == null) throw new IllegalStateException();
                output.write(data);
                output.flush();
            }
            ContentValues visible = new ContentValues();
            visible.put(MediaStore.MediaColumns.IS_PENDING, 0);
            if (context.getContentResolver().update(uri, visible, null, null) != 1) {
                throw new IllegalStateException();
            }
            return uri;
        } catch (Exception failure) {
            context.getContentResolver().delete(uri, null, null);
            throw failure;
        }
    }

    private static void verifyPair(Material material) throws Exception {
        if (!(material.certificate.getPublicKey() instanceof RSAPublicKey)
                || ((RSAPublicKey) material.certificate.getPublicKey())
                        .getModulus().bitLength() < 3072) throw new IllegalStateException();
        byte[] challenge = new byte[32];
        RANDOM.nextBytes(challenge);
        Signature signer = Signature.getInstance("SHA256withRSA");
        signer.initSign(material.privateKey);
        signer.update(challenge);
        byte[] signature = signer.sign();
        Signature verifier = Signature.getInstance("SHA256withRSA");
        verifier.initVerify(material.certificate.getPublicKey());
        verifier.update(challenge);
        if (!verifier.verify(signature)) throw new IllegalStateException();
    }

    private static PrivateKey privateKey(byte[] encoded) throws Exception {
        return KeyFactory.getInstance("RSA").generatePrivate(new PKCS8EncodedKeySpec(encoded));
    }

    private static X509Certificate certificate(byte[] encoded) throws Exception {
        return (X509Certificate) CertificateFactory.getInstance("X.509")
                .generateCertificate(new ByteArrayInputStream(encoded));
    }

    private static byte[] readBounded(InputStream input, int maximum) throws Exception {
        ByteArrayOutputStream output = new ByteArrayOutputStream();
        byte[] buffer = new byte[2048];
        int count;
        while ((count = input.read(buffer)) != -1) {
            if (output.size() + count > maximum) throw new IllegalStateException();
            output.write(buffer, 0, count);
        }
        return output.toByteArray();
    }

    private static String encode(byte[] value) {
        return Base64.encodeToString(value, Base64.NO_WRAP);
    }

    private static byte[] decode(String value) {
        return Base64.decode(value, Base64.DEFAULT);
    }

    static final class Material {
        final PrivateKey privateKey;
        final X509Certificate certificate;

        Material(PrivateKey privateKey, X509Certificate certificate) {
            this.privateKey = privateKey;
            this.certificate = certificate;
        }
    }

    static final class BackupResult {
        final Uri uri;
        final String recoveryPhrase;
        final String displayName;

        BackupResult(Uri uri, String recoveryPhrase, String displayName) {
            this.uri = uri;
            this.recoveryPhrase = recoveryPhrase;
            this.displayName = displayName;
        }
    }
}
