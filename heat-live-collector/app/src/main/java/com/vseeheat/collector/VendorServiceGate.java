package com.vseeheat.collector;

import android.content.ComponentName;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.ServiceInfo;
import android.content.pm.Signature;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/** Read-only verification of the existing V6 vendor service. No command is sent. */
final class VendorServiceGate {
    private static final String PACKAGE = "com.define.shellservice";
    private static final String SERVICE = "com.define.shellservice.ShellService";
    private static final String EXPECTED_CERT_SHA256 =
            "c8a2e9bccf597c2fb6dc66bee293fc13f2fc47ec77bc6b2b0d52c11f51192ab8";
    private static final int SYSTEM_UID = 1000;

    private VendorServiceGate() {}

    static boolean isTrusted(Context context) {
        try {
            PackageManager manager = context.getPackageManager();
            PackageInfo info = manager.getPackageInfo(PACKAGE,
                    PackageManager.GET_SIGNING_CERTIFICATES);
            if (info.applicationInfo == null || info.applicationInfo.uid != SYSTEM_UID
                    || !info.applicationInfo.enabled || info.signingInfo == null) {
                return false;
            }
            Signature[] signers = info.signingInfo.getApkContentsSigners();
            if (signers == null || signers.length != 1
                    || !EXPECTED_CERT_SHA256.equals(sha256(signers[0].toByteArray()))) {
                return false;
            }
            ServiceInfo service = manager.getServiceInfo(new ComponentName(PACKAGE, SERVICE), 0);
            return service.enabled && service.exported
                    && service.applicationInfo != null
                    && service.applicationInfo.enabled
                    && service.applicationInfo.uid == SYSTEM_UID
                    && PACKAGE.equals(service.packageName)
                    && SERVICE.equals(service.name);
        } catch (PackageManager.NameNotFoundException | NoSuchAlgorithmException
                 | RuntimeException error) {
            return false;
        }
    }

    private static String sha256(byte[] data) throws NoSuchAlgorithmException {
        byte[] digest = MessageDigest.getInstance("SHA-256").digest(data);
        StringBuilder result = new StringBuilder(digest.length * 2);
        for (byte value : digest) {
            result.append(Character.forDigit((value & 0xff) >>> 4, 16));
            result.append(Character.forDigit(value & 0x0f, 16));
        }
        return result.toString();
    }
}
