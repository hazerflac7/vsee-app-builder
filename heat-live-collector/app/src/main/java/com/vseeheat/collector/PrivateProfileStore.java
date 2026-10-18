package com.vseeheat.collector;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.security.keystore.KeyGenParameterSpec;
import android.security.keystore.KeyProperties;
import android.util.Base64;

import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.nio.charset.StandardCharsets;
import java.security.KeyStore;
import java.util.Arrays;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.GCMParameterSpec;

/** Stores sealed partial and full profiles in app-private, non-backed-up data. */
final class PrivateProfileStore {
    private static final String KEY_ALIAS = "heat_live_partial_profile_v1";
    private static final String PREFERENCES = "sealed_profile";
    private static final String FIELD = "payload";
    private static final String FULL_FIELD = "full_payload";

    private PrivateProfileStore() {}

    static boolean hasSaved(Context context) {
        try {
            return loadPartial(context) != null;
        } catch (Exception ignored) {
            return false;
        }
    }

    static JSONObject loadPartial(Context context) throws Exception {
        JSONObject profile = decrypt(context, FIELD);
        if (profile == null) return null;
        int uid = profile.getInt("originalUid");
        if (profile.getInt("format") != 1
                || !"com.google.heatlive".equals(profile.getString("originalPackage"))
                || !currentOriginalVersion(context).equals(
                        profile.getString("originalVersion"))
                || uid < 10_000 || uid >= 100_000
                || !profile.getString("androidId").matches("[0-9a-f]{16}")
                || !profile.getString("randomSn").matches("[!-~]{40}")) {
            throw new IllegalStateException();
        }
        return profile;
    }

    static void saveFull(Context context, int expectedUid) throws Exception {
        JSONObject partial = loadPartial(context);
        if (partial == null || partial.getInt("originalUid") != expectedUid) {
            throw new IllegalStateException();
        }
        JSONObject owner = DeviceProfileReader.complete(partial);
        String identity = PrivilegedCollector.verifySaved(context, expectedUid,
                partial.getString("androidId"), partial.getString("randomSn"));
        if (!"VERIFIED".equals(identity)) {
            if ("IDENTITY_CHANGED".equals(identity)) invalidateProfile(context);
            throw new IdentityFailure(identity);
        }
        JSONObject full = new JSONObject();
        full.put("format", 2);
        full.put("originalPackage", "com.google.heatlive");
        full.put("originalVersion", partial.getString("originalVersion"));
        full.put("originalUid", expectedUid);
        full.put("firmwareFingerprint", android.os.Build.FINGERPRINT);
        full.put("ownerProfile", owner);
        seal(context, FULL_FIELD, full);
    }

    static void invalidateProfile(Context context) {
        if (!context.getSharedPreferences(PREFERENCES, Context.MODE_PRIVATE).edit()
                .remove(FIELD).remove(FULL_FIELD).commit()) {
            throw new IllegalStateException();
        }
    }

    static final class IdentityFailure extends Exception {
        final String stage;

        IdentityFailure(String stage) {
            this.stage = stage;
        }
    }

    static JSONObject loadFull(Context context, int expectedUid) throws Exception {
        JSONObject full = decrypt(context, FULL_FIELD);
        if (full == null) return null;
        if (full.getInt("format") != 2
                || !"com.google.heatlive".equals(full.getString("originalPackage"))
                || !currentOriginalVersion(context).equals(
                        full.getString("originalVersion"))
                || full.getInt("originalUid") != expectedUid
                || false && !android.os.Build.FINGERPRINT.equals(
                        full.getString("firmwareFingerprint"))) {
            throw new IllegalStateException();
        }
        JSONObject owner = full.getJSONObject("ownerProfile");
        DeviceProfileReader.validate(owner);
        JSONObject partial = loadPartial(context);
        if (partial == null || partial.getInt("originalUid") != expectedUid
                || !full.getString("originalVersion").equals(
                        partial.getString("originalVersion"))
                || !owner.getString("androidId").equals(partial.getString("androidId"))
                || !owner.getString("randomSn").equals(partial.getString("randomSn"))) {
            throw new IllegalStateException();
        }
        return owner;
    }

    static void save(Context context, int originalUid, String androidId,
                     String randomSn) throws Exception {
        if (originalUid < 10_000 || originalUid >= 100_000
                || !androidId.matches("[0-9a-f]{16}")
                || !randomSn.matches("[!-~]{40}")) {
            throw new IllegalArgumentException();
        }
        JSONObject profile = new JSONObject();
        profile.put("format", 1);
        profile.put("originalPackage", "com.google.heatlive");
        profile.put("originalVersion", currentOriginalVersion(context));
        profile.put("originalUid", originalUid);
        profile.put("androidId", androidId);
        profile.put("randomSn", randomSn);

        seal(context, FIELD, profile);
        // A newly collected partial profile invalidates any previous full profile.
        if (!context.getSharedPreferences(PREFERENCES, Context.MODE_PRIVATE).edit()
                .remove(FULL_FIELD).commit()) {
            throw new IllegalStateException();
        }
    }

    private static String currentOriginalVersion(Context context) throws Exception {
        PackageInfo info = context.getPackageManager().getPackageInfo(
                "com.google.heatlive", 0);
        if (!HeatLiveGate.approvedVersion(context, info.versionName,
                info.getLongVersionCode())) throw new IllegalStateException();
        return info.versionName;
    }

    private static void seal(Context context, String field, JSONObject profile) throws Exception {
        Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
        cipher.init(Cipher.ENCRYPT_MODE, getOrCreateKey());
        byte[] encrypted = cipher.doFinal(profile.toString().getBytes(StandardCharsets.UTF_8));
        byte[] iv = cipher.getIV();
        if (iv == null || iv.length != 12) throw new IllegalStateException();
        ByteArrayOutputStream packed = new ByteArrayOutputStream(1 + iv.length + encrypted.length);
        packed.write(iv.length);
        packed.write(iv);
        packed.write(encrypted);
        SharedPreferences store = context.getSharedPreferences(PREFERENCES, Context.MODE_PRIVATE);
        if (!store.edit().putString(field,
                Base64.encodeToString(packed.toByteArray(), Base64.NO_WRAP)).commit()) {
            throw new IllegalStateException();
        }
    }

    private static JSONObject decrypt(Context context, String field) throws Exception {
        String sealed = context.getSharedPreferences(PREFERENCES, Context.MODE_PRIVATE)
                .getString(field, null);
        if (sealed == null) return null;
        SecretKey key = existingKey();
        if (key == null) throw new IllegalStateException();
        byte[] packed = Base64.decode(sealed, Base64.DEFAULT);
        if (packed.length < 29 || (packed[0] & 0xff) != 12) throw new IllegalStateException();
        byte[] iv = Arrays.copyOfRange(packed, 1, 13);
        Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
        cipher.init(Cipher.DECRYPT_MODE, key, new GCMParameterSpec(128, iv));
        return new JSONObject(new String(cipher.doFinal(packed, 13,
                packed.length - 13), StandardCharsets.UTF_8));
    }

    private static SecretKey getOrCreateKey() throws Exception {
        SecretKey existing = existingKey();
        if (existing != null) return existing;
        KeyGenerator generator = KeyGenerator.getInstance(
                KeyProperties.KEY_ALGORITHM_AES, "AndroidKeyStore");
        generator.init(new KeyGenParameterSpec.Builder(KEY_ALIAS,
                KeyProperties.PURPOSE_ENCRYPT | KeyProperties.PURPOSE_DECRYPT)
                .setBlockModes(KeyProperties.BLOCK_MODE_GCM)
                .setEncryptionPaddings(KeyProperties.ENCRYPTION_PADDING_NONE)
                .setKeySize(256)
                .build());
        return generator.generateKey();
    }

    private static SecretKey existingKey() throws Exception {
        KeyStore keyStore = KeyStore.getInstance("AndroidKeyStore");
        keyStore.load(null);
        KeyStore.Entry entry = keyStore.getEntry(KEY_ALIAS, null);
        return entry instanceof KeyStore.SecretKeyEntry
                ? ((KeyStore.SecretKeyEntry) entry).getSecretKey() : null;
    }
}
