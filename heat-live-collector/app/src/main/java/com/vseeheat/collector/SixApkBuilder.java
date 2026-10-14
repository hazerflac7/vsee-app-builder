package com.vseeheat.collector;

import android.content.Context;
import android.net.Uri;
import android.os.Environment;

import org.json.JSONObject;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Locale;

/** One owner action creates six APKs or removes this batch on failure. */
final class SixApkBuilder {
    interface Progress { void update(int completed, String message); }

    static final class Result {
        final String folder;
        final int count;

        Result(String folder, int count) {
            this.folder = folder;
            this.count = count;
        }
    }

    private SixApkBuilder() {}

    static Result buildAll(Context context, Progress progress) throws Exception {
        HeatLiveGate.Result live = HeatLiveGate.inspect(context);
        if (!live.supported() || !OtherHeatGate.allSupported(
                OtherHeatGate.inspectAll(context))) {
            throw new HeatLiveApkBuilder.BuildFailure("COMPATIBILITY_CHANGED");
        }
        JSONObject profile;
        try {
            profile = PrivateProfileStore.loadFull(context, live.originalUid);
            if (profile == null) throw new IllegalStateException();
        } catch (Exception ignored) {
            throw new HeatLiveApkBuilder.BuildFailure("FULL_PROFILE_MISSING");
        }
        OwnerSigningKeys.Material owner = OwnerSigningKeys.load(context);
        if (owner == null) owner = OwnerSigningKeys.createLocal(context);
        if (owner == null) {
            throw new HeatLiveApkBuilder.BuildFailure("OWNER_KEY_UNAVAILABLE");
        }
        String[] additionalIds = PrivilegedCollector.currentAdditionalIds(context);

        String folder = "Vsee-Apps-" + new SimpleDateFormat("yyyyMMdd-HHmmss",
                Locale.US).format(new Date());
        String relativePath = Environment.DIRECTORY_DOWNLOADS + "/" + folder + "/";
        List<Uri> exported = new ArrayList<>(6);
        try {
            progress.update(0, "Making 1 of 6: Heat Live");
            exported.add(HeatLiveApkBuilder.build(context, relativePath));
            progress.update(1, "Saved 1 of 6: Heat Live");
            for (int index = 0; index < HeatAppSpec.OTHER.length; index++) {
                HeatAppSpec.Spec spec = HeatAppSpec.OTHER[index];
                progress.update(index + 1, "Making " + (index + 2) + " of 6: " + spec.label);
                JSONObject appProfile = new JSONObject(profile.toString());
                appProfile.put("androidId", additionalIds[index]);
                DeviceProfileReader.validate(appProfile);
                exported.add(OtherHeatApkBuilder.build(context, spec, appProfile,
                        owner, relativePath));
                progress.update(index + 2, "Saved " + (index + 2)
                        + " of 6: " + spec.label);
            }
            HeatLiveApkBuilder.verifyCurrentProfile(context, live.originalUid, profile);
            if (!Arrays.equals(additionalIds,
                    PrivilegedCollector.currentAdditionalIds(context))) {
                throw new HeatLiveApkBuilder.BuildFailure("IDENTITY_CHANGED");
            }
            if (!OtherHeatGate.allSupported(OtherHeatGate.inspectAll(context))) {
                throw new HeatLiveApkBuilder.BuildFailure("COMPATIBILITY_CHANGED");
            }
            progress.update(6, "All six APKs saved");
            return new Result(folder, exported.size());
        } catch (Exception failure) {
            boolean removed = true;
            for (Uri uri : exported) {
                try {
                    removed &= context.getContentResolver().delete(uri, null, null) == 1;
                } catch (Exception ignored) {
                    removed = false;
                }
            }
            if (!removed) throw new HeatLiveApkBuilder.BuildFailure("PARTIAL_OUTPUTS");
            throw failure;
        }
    }
}
