package com.vseeheat.collector;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;

import java.io.File;

/** Per-app checks for the five additional original Heat installations. */
final class OtherHeatGate {
    private OtherHeatGate() {}

    static Status[] inspectAll(Context context) {
        Status[] checks = new Status[HeatAppSpec.OTHER.length];
        for (int index = 0; index < checks.length; index++) {
            checks[index] = inspectOne(context, HeatAppSpec.OTHER[index]);
        }
        return checks;
    }

    static boolean allSupported(Status[] checks) {
        if (checks == null || checks.length != HeatAppSpec.OTHER.length) return false;
        for (Status status : checks) {
            if (status == null || !status.supported()) return false;
        }
        return true;
    }

    static boolean selectedSupported(Status[] checks, boolean[] selected) {
        if (checks == null || checks.length != HeatAppSpec.OTHER.length
                || selected == null || selected.length != 6) return false;
        for (int index = 0; index < checks.length; index++) {
            if (selected[index + 1] && (checks[index] == null
                    || !checks[index].supported())) return false;
        }
        return true;
    }

    static String summary(Status[] checks) {
        StringBuilder summary = new StringBuilder("Additional Heat apps:\n");
        if (checks == null) return summary.append("Not checked").toString();
        for (Status status : checks) {
            summary.append(status.spec.label).append(": ")
                    .append(status.supported() ? "Verified" : status.reason())
                    .append("\n");
        }
        return summary.toString().trim();
    }

    static Status inspectOne(Context context, HeatAppSpec.Spec spec) {
        Status result = new Status(spec);
        try {
            PackageInfo info = context.getPackageManager().getPackageInfo(
                    spec.originalPackage, PackageManager.GET_SIGNING_CERTIFICATES);
            result.found = true;
            result.version = info.versionName == null ? "(unavailable)" : info.versionName;
            HeatAppSpec.Spec updated = CompatibilityUpdates.resolve(context,
                    spec.originalPackage, info.versionName, info.getLongVersionCode());
            boolean baseVersion = spec.versionName.equals(info.versionName)
                    && spec.versionCode == info.getLongVersionCode();
            result.versionMatches = baseVersion || updated != null;
            ApplicationInfo app = info.applicationInfo;
            result.ownerUser = app != null && app.uid >= 10_000 && app.uid < 100_000;
            result.originalUid = result.ownerUser ? app.uid : -1;
            result.singleApk = app != null && app.sourceDir != null
                    && app.sourceDir.startsWith("/data/app/")
                    && (app.splitSourceDirs == null || app.splitSourceDirs.length == 0);
            if (info.signingInfo != null) {
                Signature[] signers = info.signingInfo.getApkContentsSigners();
                result.signerMatches = signers != null && signers.length == 1
                        && HeatLiveGate.SIGNER_SHA256.equals(
                        HeatLiveGate.sha256(signers[0].toByteArray()));
            }
            if (result.versionMatches && result.signerMatches && result.singleApk
                    && result.ownerUser) {
                File apk = new File(app.sourceDir);
                if (apk.isFile() && apk.length() > 0
                        && apk.length() <= HeatLiveGate.MAX_APK_BYTES) {
                    byte[] hash = HeatLiveGate.hashFile(apk);
                    result.readable = hash != null;
                    if (result.readable) {
                        String actualHash = HeatLiveGate.toHex(hash);
                        boolean baseExact = baseVersion
                                && apk.length() == spec.originalBytes
                                && spec.originalSha256.equals(actualHash);
                        boolean remoteExact = updated != null
                                && apk.length() == updated.originalBytes
                                && updated.originalSha256.equals(actualHash);
                        String payload = baseExact || remoteExact ? null
                                : HeatLiveGate.payloadHash(apk);
                        boolean basePayload = baseVersion
                                && spec.payloadSha256.equals(payload);
                        boolean remotePayload = updated != null
                                && updated.payloadSha256.equals(payload);
                        if (!baseExact && !basePayload
                                && (remoteExact || remotePayload)) {
                            result.spec = updated;
                            result.exact = remoteExact;
                            result.payloadMatches = remotePayload;
                        } else {
                            result.exact = baseExact;
                            result.payloadMatches = basePayload;
                        }
                    }
                }
            }
        } catch (Exception ignored) {
            // No private paths, signatures, or exception text are shown to the owner.
        }
        return result;
    }

    static final class Status {
        HeatAppSpec.Spec spec;
        String version = "(unavailable)";
        boolean found;
        boolean versionMatches;
        boolean signerMatches;
        boolean singleApk;
        boolean ownerUser;
        int originalUid = -1;
        boolean readable;
        boolean exact;
        boolean payloadMatches;

        Status(HeatAppSpec.Spec spec) { this.spec = spec; }

        boolean supported() {
            return found && versionMatches && signerMatches && singleApk && ownerUser
                    && readable && (exact || payloadMatches);
        }

        String reason() {
            if (!found) return "Not installed";
            if (!versionMatches) return "Version " + version + " is not supported";
            if (!signerMatches) return "Original signature not verified";
            if (!singleApk || !ownerUser) return "Installation not supported";
            if (!readable) return "Could not read original app";
            return "App contents changed";
        }
    }
}
