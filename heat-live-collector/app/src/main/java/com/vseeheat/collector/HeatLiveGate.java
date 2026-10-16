package com.vseeheat.collector;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.os.Build;
import android.os.Process;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

/** Checks the exact original APK used by the saved Heat Live prototype. */
final class HeatLiveGate {
    private static final String PACKAGE = "com.google.heatlive";
    private static final String FIRMWARE_FINGERPRINT =
            "Amlogic/qurra/qurra:14/UD2A.240505.001.W1/define07141701:userdebug/dev-keys";
    private static final String VERSION_594 = "5.9.4";
    private static final String VERSION_595 = "5.9.5";
    private static final long APK_BYTES_594 = 24_045_136L;
    private static final long APK_BYTES_595 = 24_054_804L;
    static final long MAX_APK_BYTES = 64L * 1024 * 1024;
    private static final long MAX_UNCOMPRESSED_BYTES = 64L * 1024 * 1024;
    private static final String APK_SHA256_594 =
            "2f1b8c3ec233867f715d664061e00f2e8bf6f4fa5a79b301405140d096177822";
    private static final String APK_SHA256_595 =
            "f5f4c4147f54a4720d7ed0cc6b30d7657d0e603a7098422a8aa676e399b8d37b";
    // Digest of sorted APK entry names, lengths and uncompressed contents, excluding
    // the Android v1 signature files. Recompression may change the APK hash without
    // changing the app. Code, resources and manifest must still match exactly.
    private static final String PAYLOAD_SHA256_594 =
            "09eaeef2d402cbbc774f8314dcf90b62047ddf69b87345f9342122d888f5920f";
    private static final String PAYLOAD_SHA256_595 =
            "bc42e09a79fcff8b45515eddccb2bf43c7c533df8d19a47303187abe9fbf05eb";
    static final String SIGNER_SHA256 =
            "cb4e4c877a0247dfa23e926cb369a7f4901208a722e215bc24493848ac32e020";

    private HeatLiveGate() {}

    static Result inspect(Context context) {
        // Android app context sees these vendor Build fields on the tested V6.
        // The generic shell ro.product values are different on this firmware.
        boolean deviceMatches = "chke".equals(Build.MANUFACTURER)
                && "V6-Plus".equals(Build.MODEL);
        boolean firmwareMatches = FIRMWARE_FINGERPRINT.equals(Build.FINGERPRINT);
        boolean vendorServiceMatches = VendorServiceGate.isTrusted(context);
        boolean originalFound = false;
        boolean versionMatches = false;
        boolean signerMatches = false;
        boolean singleApk = false;
        boolean apkReadable = false;
        boolean apkMatches = false;
        boolean payloadMatches = false;
        String installedVersion = "(unavailable)";
        long installedVersionCode = -1;
        int originalUid = -1;
        boolean ownerUser = Process.myUid() >= 10_000 && Process.myUid() < 100_000;
        HeatAppSpec.Spec remoteSpec = null;

        try {
            PackageManager manager = context.getPackageManager();
            PackageInfo info = manager.getPackageInfo(PACKAGE,
                    PackageManager.GET_SIGNING_CERTIFICATES);
            originalFound = true;
            installedVersion = safeBuildText(info.versionName);
            installedVersionCode = info.getLongVersionCode();
            HeatAppSpec.Spec candidate = CompatibilityUpdates.resolve(context,
                    PACKAGE, info.versionName, info.getLongVersionCode());
            versionMatches = approvedVersion(info.versionName,
                    info.getLongVersionCode()) || candidate != null;
            ApplicationInfo app = info.applicationInfo;
            if (app != null) originalUid = app.uid;
            ownerUser = ownerUser && originalUid >= 10_000 && originalUid < 100_000;
            singleApk = app != null && app.sourceDir != null
                    && (app.splitSourceDirs == null || app.splitSourceDirs.length == 0);
            if (info.signingInfo != null) {
                Signature[] signers = info.signingInfo.getApkContentsSigners();
                signerMatches = signers != null && signers.length == 1
                        && SIGNER_SHA256.equals(sha256(signers[0].toByteArray()));
            }

            // Read only the installed package path, and only after Android confirms
            // the original signer. Limit both ZIP size and expanded payload size.
            if (deviceMatches && firmwareMatches
                    && signerMatches && singleApk) {
                File apk = new File(app.sourceDir);
                if (apk.isFile() && apk.length() > 0
                        && apk.length() <= MAX_APK_BYTES) {
                    byte[] digest = hashFile(apk);
                    apkReadable = digest != null;
                    boolean is595 = VERSION_595.equals(info.versionName);
                    boolean builtIn = approvedVersion(info.versionName,
                            info.getLongVersionCode());
                    String actual = digest == null ? "" : toHex(digest);
                    boolean builtInExact = builtIn && digest != null
                            && apk.length() == (is595 ? APK_BYTES_595 : APK_BYTES_594)
                            && (is595 ? APK_SHA256_595 : APK_SHA256_594).equals(actual);
                    boolean remoteExact = candidate != null && digest != null
                            && apk.length() == candidate.originalBytes
                            && candidate.originalSha256.equals(actual);
                    apkMatches = builtInExact || remoteExact;
                    if (versionMatches && apkReadable) {
                        String payload = payloadHash(apk);
                        boolean builtInPayload = builtIn && (is595
                                ? PAYLOAD_SHA256_595 : PAYLOAD_SHA256_594).equals(payload);
                        boolean remotePayload = candidate != null
                                && candidate.payloadSha256.equals(payload);
                        payloadMatches = builtInPayload || remotePayload;
                        if (!builtInExact && !builtInPayload
                                && (remoteExact || remotePayload)) remoteSpec = candidate;
                    }
                }
            }
        } catch (PackageManager.NameNotFoundException | NoSuchAlgorithmException
                 | RuntimeException ignored) {
            // Status stays unverified. No exception text or path reaches the UI/log.
        }

        return new Result(deviceMatches, firmwareMatches,
                safeBuildText(Build.MANUFACTURER), safeBuildText(Build.MODEL),
                originalFound, versionMatches, signerMatches,
                singleApk, apkReadable, apkMatches, payloadMatches,
                vendorServiceMatches, ownerUser, originalUid,
                installedVersion, installedVersionCode, remoteSpec);
    }

    static boolean approvedVersion(String name, long code) {
        return (VERSION_594.equals(name) && code == 594)
                || (VERSION_595.equals(name) && code == 595);
    }

    static boolean approvedVersion(Context context, String name, long code) {
        return approvedVersion(name, code)
                || CompatibilityUpdates.resolve(context, PACKAGE, name, code) != null;
    }

    static String builtInOriginalHash(String name, long code) {
        if (VERSION_594.equals(name) && code == 594) return APK_SHA256_594;
        if (VERSION_595.equals(name) && code == 595) return APK_SHA256_595;
        return null;
    }

    static byte[] hashFile(File file) {
        try (BufferedInputStream input = new BufferedInputStream(new FileInputStream(file))) {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] buffer = new byte[8192];
            long bytes = 0;
            int count;
            while ((count = input.read(buffer)) != -1) {
                bytes += count;
                if (bytes > MAX_APK_BYTES) return null;
                digest.update(buffer, 0, count);
            }
            return bytes > 0 ? digest.digest() : null;
        } catch (IOException | NoSuchAlgorithmException ignored) {
            return null;
        }
    }

    static String payloadHash(File apk) {
        try (ZipFile zip = new ZipFile(apk)) {
            if (zip.size() < 1 || zip.size() > 3000) return null;
            ArrayList<String> names = new ArrayList<>();
            Set<String> seen = new HashSet<>();
            java.util.Enumeration<? extends ZipEntry> entries = zip.entries();
            while (entries.hasMoreElements()) {
                ZipEntry entry = entries.nextElement();
                String name = entry.getName();
                if (!seen.add(name)) return null;
                if (!isSignatureEntry(name)) names.add(name);
            }
            Collections.sort(names);
            MessageDigest all = MessageDigest.getInstance("SHA-256");
            long expanded = 0;
            byte[] block = new byte[8192];
            for (String name : names) {
                ZipEntry entry = zip.getEntry(name);
                if (entry == null || entry.getSize() < 0
                        || entry.getSize() > 32L * 1024 * 1024) return null;
                MessageDigest content = MessageDigest.getInstance("SHA-256");
                long count = 0;
                try (java.io.InputStream input = zip.getInputStream(entry)) {
                    int read;
                    while ((read = input.read(block)) != -1) {
                        count += read;
                        expanded += read;
                        if (count > 32L * 1024 * 1024
                                || expanded > MAX_UNCOMPRESSED_BYTES) return null;
                        content.update(block, 0, read);
                    }
                }
                if (count != entry.getSize()) return null;
                byte[] nameBytes = name.getBytes(StandardCharsets.UTF_8);
                updateNumber(all, nameBytes.length, 4);
                all.update(nameBytes);
                updateNumber(all, count, 8);
                all.update(content.digest());
            }
            return toHex(all.digest());
        } catch (IOException | NoSuchAlgorithmException | RuntimeException ignored) {
            return null;
        }
    }

    private static void updateNumber(MessageDigest digest, long value, int width) {
        for (int shift = (width - 1) * 8; shift >= 0; shift -= 8) {
            digest.update((byte) (value >>> shift));
        }
    }

    private static boolean isSignatureEntry(String name) {
        String upper = name.toUpperCase(java.util.Locale.US);
        return upper.startsWith("META-INF/")
                && (upper.endsWith(".RSA") || upper.endsWith(".DSA")
                    || upper.endsWith(".EC") || upper.endsWith(".SF")
                    || upper.equals("META-INF/MANIFEST.MF"));
    }

    static String sha256(byte[] data) throws NoSuchAlgorithmException {
        return toHex(MessageDigest.getInstance("SHA-256").digest(data));
    }

    static String toHex(byte[] data) {
        StringBuilder value = new StringBuilder(data.length * 2);
        for (byte item : data) {
            value.append(Character.forDigit((item & 0xff) >>> 4, 16));
            value.append(Character.forDigit(item & 0x0f, 16));
        }
        return value.toString();
    }

    private static String safeBuildText(String value) {
        if (value == null || value.isEmpty()) return "(empty)";
        StringBuilder safe = new StringBuilder();
        for (int index = 0; index < value.length() && safe.length() < 64; index++) {
            char item = value.charAt(index);
            if (item >= 32 && item <= 126) safe.append(item);
        }
        return safe.length() == 0 ? "(unavailable)" : safe.toString();
    }

    static final class Result {
        final boolean deviceMatches;
        final boolean firmwareMatches;
        final String observedManufacturer;
        final String observedModel;
        final boolean originalFound;
        final boolean versionMatches;
        final boolean signerMatches;
        final boolean singleApk;
        final boolean apkReadable;
        final boolean apkMatches;
        final boolean payloadMatches;
        final boolean vendorServiceMatches;
        final boolean ownerUser;
        final int originalUid;
        final String installedVersion;
        final long installedVersionCode;
        final HeatAppSpec.Spec remoteSpec;

        Result(boolean deviceMatches, boolean firmwareMatches,
               String observedManufacturer, String observedModel,
               boolean originalFound, boolean versionMatches,
               boolean signerMatches, boolean singleApk, boolean apkReadable,
               boolean apkMatches, boolean payloadMatches,
               boolean vendorServiceMatches, boolean ownerUser, int originalUid,
               String installedVersion, long installedVersionCode,
               HeatAppSpec.Spec remoteSpec) {
            this.deviceMatches = deviceMatches;
            this.firmwareMatches = firmwareMatches;
            this.observedManufacturer = observedManufacturer;
            this.observedModel = observedModel;
            this.originalFound = originalFound;
            this.versionMatches = versionMatches;
            this.signerMatches = signerMatches;
            this.singleApk = singleApk;
            this.apkReadable = apkReadable;
            this.apkMatches = apkMatches;
            this.payloadMatches = payloadMatches;
            this.vendorServiceMatches = vendorServiceMatches;
            this.ownerUser = ownerUser;
            this.originalUid = originalUid;
            this.installedVersion = installedVersion;
            this.installedVersionCode = installedVersionCode;
            this.remoteSpec = remoteSpec;
        }

        boolean supported() {
            return deviceMatches && firmwareMatches && originalFound
                    && versionMatches && signerMatches
                    && singleApk && apkReadable && (apkMatches || payloadMatches)
                    && vendorServiceMatches
                    && ownerUser;
        }

        boolean trustedUpdateDetected() {
            return deviceMatches && firmwareMatches && originalFound
                    && signerMatches && singleApk && apkReadable
                    && !supported();
        }
    }
}
