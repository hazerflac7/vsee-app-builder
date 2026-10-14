package com.vseeheat.collector;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.net.LocalServerSocket;
import android.net.LocalSocket;
import android.system.Os;
import android.system.OsConstants;

import java.io.DataInputStream;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

/** One-shot, local-only channel to the fixed read-only vendor-service probe. */
final class PrivilegedCollector {
    private static final ComponentName SERVICE = new ComponentName(
            "com.define.shellservice", "com.define.shellservice.ShellService");
    private static final SecureRandom RANDOM = new SecureRandom();

    private PrivilegedCollector() {}

    static String collect(Context context) {
        Reply reply = probe(context);
        if (!"OK".equals(reply.status)) return reply.status;
        try {
            PrivateProfileStore.save(context, reply.originalUid,
                    reply.androidId, reply.randomSn);
        } catch (Exception ignored) {
            return "STORE_FAILED";
        }
        return "SAVED";
    }

    /** Re-reads the original app's current V6 records without changing saved data. */
    static String verifySaved(Context context, int expectedUid,
                              String expectedAndroidId, String expectedRandomSn) {
        if (expectedUid < 10_000 || expectedUid >= 100_000
                || expectedAndroidId == null
                || !expectedAndroidId.matches("[0-9a-f]{16}")
                || expectedRandomSn == null
                || !expectedRandomSn.matches("[!-~]{40}")) {
            return "CHECK_FAILED";
        }
        Reply reply = probe(context);
        if (!"OK".equals(reply.status)) return reply.status;
        if (reply.originalUid != expectedUid
                || !same(reply.androidId, expectedAndroidId)
                || !same(reply.randomSn, expectedRandomSn)) {
            return "IDENTITY_CHANGED";
        }
        return "VERIFIED";
    }

    /** Reads the five originals' current app-specific IDs for the six-APK batch. */
    static String[] currentAdditionalIds(Context context)
            throws HeatLiveApkBuilder.BuildFailure {
        Reply reply = probe(context);
        if (!"OK".equals(reply.status)) {
            throw new HeatLiveApkBuilder.BuildFailure(reply.status);
        }
        for (int index = 0; index < reply.additionalIds.length; index++) {
            if (reply.additionalIds[index].isEmpty()) {
                throw new HeatLiveApkBuilder.BuildFailure("OPEN_ORIGINAL_APP_" + (index + 2));
            }
        }
        return reply.additionalIds.clone();
    }

    private static boolean same(String left, String right) {
        return MessageDigest.isEqual(left.getBytes(StandardCharsets.US_ASCII),
                right.getBytes(StandardCharsets.US_ASCII));
    }

    private static Reply failed(String status) {
        return new Reply(status, "", "", -1, new String[5]);
    }

    private static Reply probe(Context context) {
        // Recheck everything at the tap; the original app could have updated since
        // the previous screen scan. Never dispatch a privileged command otherwise.
        HeatLiveGate.Result gate = HeatLiveGate.inspect(context);
        OtherHeatGate.Status[] otherApps = OtherHeatGate.inspectAll(context);
        if (!gate.supported() || !OtherHeatGate.allSupported(otherApps)
                || !VendorServiceGate.isTrusted(context)) {
            return failed("CHECK_FAILED");
        }
        String source = context.getApplicationInfo().sourceDir;
        if (source == null || !source.startsWith("/data/app/")) {
            return failed("CHECK_FAILED");
        }
        String socketName = "heatcollector_" + randomHex();
        String token = randomHex();
        LocalServerSocket server = null;
        ExecutorService replyWorker = Executors.newSingleThreadExecutor(runnable -> {
            Thread thread = new Thread(runnable, "heat-collector-reply");
            thread.setDaemon(true);
            return thread;
        });
        try {
            server = new LocalServerSocket(socketName);
            final LocalServerSocket replyServer = server;
            Future<Reply> pending = replyWorker.submit(new Callable<Reply>() {
                @Override public Reply call() throws Exception {
                    try (LocalSocket socket = replyServer.accept()) {
                        socket.setSoTimeout(4000);
                        int senderUid = socket.getPeerCredentials().getUid();
                        if (senderUid != 1000) return failed("CHANNEL_REJECTED");
                        DataInputStream input = new DataInputStream(socket.getInputStream());
                        if (!token.equals(input.readUTF())) {
                            return failed("CHANNEL_REJECTED");
                        }
                        String status = input.readUTF();
                        String androidId = input.readUTF();
                        String randomSn = input.readUTF();
                        String[] additionalIds = new String[otherApps.length];
                        for (int index = 0; index < additionalIds.length; index++) {
                            additionalIds[index] = input.readUTF();
                        }
                        if (!validStatus(status)) return failed("CHANNEL_REJECTED");
                        if ("OK".equals(status) && (!androidId.matches("[0-9a-f]{16}")
                                || !randomSn.matches("[!-~]{40}"))) {
                            return failed("CHANNEL_REJECTED");
                        }
                        if (!"OK".equals(status)
                                && (!androidId.isEmpty() || !randomSn.isEmpty())) {
                            return failed("CHANNEL_REJECTED");
                        }
                        for (String id : additionalIds) {
                            if (id == null || !(id.isEmpty()
                                    || id.matches("[0-9a-f]{16}"))
                                    || (!"OK".equals(status) && !id.isEmpty())) {
                                return failed("CHANNEL_REJECTED");
                            }
                        }
                        return new Reply(status, androidId, randomSn,
                                gate.originalUid, additionalIds);
                    }
                }
            });

            String command = "CLASSPATH=" + quote(source)
                    + " /system/bin/timeout 38 /system/bin/app_process /system/bin "
                    + "com.vseeheat.collector.ProfileProbeMain "
                    + quote(socketName) + " " + quote(token) + " " + gate.originalUid;
            for (OtherHeatGate.Status app : otherApps) {
                command += " " + app.originalUid;
            }
            command += " >/dev/null 2>&1";
            Intent request = new Intent().setComponent(SERVICE).putExtra("command", command);
            try {
                if (context.startService(request) == null) return failed("SERVICE_START_FAILED");
            } catch (Exception ignored) {
                return failed("SERVICE_START_FAILED");
            }
            Reply reply;
            try {
                reply = pending.get(43, TimeUnit.SECONDS);
            } catch (TimeoutException ignored) {
                return failed("PROBE_TIMEOUT");
            } catch (Exception ignored) {
                return failed("CHANNEL_FAILED");
            }
            if (!"OK".equals(reply.status)) return reply;
            HeatLiveGate.Result after = HeatLiveGate.inspect(context);
            if (!after.supported() || after.originalUid != gate.originalUid) {
                return failed("CHECK_FAILED");
            }
            return reply;
        } catch (Exception ignored) {
            return failed("CHANNEL_FAILED");
        } finally {
            if (server != null) {
                try { Os.shutdown(server.getFileDescriptor(), OsConstants.SHUT_RDWR); }
                catch (Exception ignored) {}
                try { server.close(); } catch (Exception ignored) {}
            }
            replyWorker.shutdownNow();
        }
    }

    private static boolean validStatus(String status) {
        return "OK".equals(status)
                || "OPEN_ORIGINAL_APP_FIRST".equals(status)
                || "PREFERENCE_UNAVAILABLE".equals(status)
                || "ROOT_ADB_NOT_READY".equals(status)
                || "ROOT_ADB_UNVERIFIED".equals(status)
                || "SSAID_READ_FAILED".equals(status)
                || "PREFERENCE_READ_FAILED".equals(status)
                || "PROBE_FAILED".equals(status);
    }

    private static String randomHex() {
        byte[] bytes = new byte[16];
        RANDOM.nextBytes(bytes);
        StringBuilder value = new StringBuilder(32);
        for (byte item : bytes) {
            value.append(Character.forDigit((item & 0xff) >>> 4, 16));
            value.append(Character.forDigit(item & 0x0f, 16));
        }
        return value.toString();
    }

    private static String quote(String value) {
        return "'" + value.replace("'", "'\"'\"'") + "'";
    }

    private static final class Reply {
        final String status;
        final String androidId;
        final String randomSn;
        final int originalUid;
        final String[] additionalIds;

        Reply(String status, String androidId, String randomSn, int originalUid,
              String[] additionalIds) {
            this.status = status;
            this.androidId = androidId;
            this.randomSn = randomSn;
            this.originalUid = originalUid;
            this.additionalIds = additionalIds;
        }
    }
}
