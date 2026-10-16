package com.vseeheat.collector;

import android.net.LocalSocket;
import android.net.LocalSocketAddress;
import android.os.Process;
import android.util.Xml;

import org.xmlpull.v1.XmlPullParser;

import java.io.DataOutputStream;
import java.io.IOException;
import java.io.StringReader;

/** Fixed, read-only probe launched by the verified system-UID V6 service. */
public final class ProfileProbeMain {
    private static final String PACKAGE = "com.google.heatlive";
    private static final String[] ADDITIONAL_PACKAGES = {
            "com.google.heatvod", "com.google.heatvodultra",
            "com.google.heatlivebackup", "com.google.liveultra",
            "com.google.liveultraplus"
    };

    private ProfileProbeMain() {}

    public static void main(String[] args) {
        if (args.length != 8 || Process.myUid() != 1000
                || !args[0].matches("heatcollector_[0-9a-f]{32}")
                || !args[1].matches("[0-9a-f]{32}")
                || !args[2].matches("[0-9]{5}")) {
            return;
        }
        for (int index = 0; index < ADDITIONAL_PACKAGES.length; index++) {
            if (!args[index + 3].matches("[0-9]{5}")) return;
        }
        String status = "PROBE_FAILED";
        String androidId = "";
        String randomSn = "";
        String[] additionalIds = {"", "", "", "", ""};
        try {
            int uid = Integer.parseInt(args[2]);
            if (uid < 10_000 || uid >= 100_000) throw new IOException();
            TrustedRootAdb rootAdb;
            try {
                rootAdb = TrustedRootAdb.findActive();
            } catch (Exception ignored) {
                throw new StageFailure("ROOT_ADB_NOT_READY");
            }
            try {
                rootAdb.verifyRootShell();
            } catch (Exception ignored) {
                throw new StageFailure("ROOT_ADB_UNVERIFIED");
            }
            try {
                String table = rootAdb.readSsaid();
                androidId = readSsaid(table, args[2], PACKAGE);
                for (int index = 0; index < ADDITIONAL_PACKAGES.length; index++) {
                    if ("00000".equals(args[index + 3])) continue;
                    String found = readSsaid(table, args[index + 3],
                            ADDITIONAL_PACKAGES[index]);
                    additionalIds[index] = found == null ? "" : found;
                }
            } catch (Exception ignored) {
                throw new StageFailure("SSAID_READ_FAILED");
            }
            if (androidId == null) {
                status = "OPEN_ORIGINAL_APP_FIRST";
                androidId = "";
                additionalIds = new String[]{"", "", "", "", ""};
            } else {
                try {
                    randomSn = readRandomSn(rootAdb.readPreference());
                } catch (Exception ignored) {
                    throw new StageFailure("PREFERENCE_READ_FAILED");
                }
                if (randomSn == null) {
                    status = "PREFERENCE_UNAVAILABLE";
                    androidId = "";
                    randomSn = "";
                    additionalIds = new String[]{"", "", "", "", ""};
                } else {
                    status = "OK";
                }
            }
        } catch (StageFailure failure) {
            status = failure.status;
            androidId = "";
            randomSn = "";
            additionalIds = new String[]{"", "", "", "", ""};
        } catch (Throwable ignored) {
            // Never print an exception or a private value to logcat or service output.
            androidId = "";
            randomSn = "";
            additionalIds = new String[]{"", "", "", "", ""};
        }
        send(args[0], args[1], status, androidId, randomSn, additionalIds);
    }

    private static String readSsaid(String xml, String uid, String expectedPackage)
            throws Exception {
        // V6 abx2xml emits <namespaceHashes> after </settings>. Parse only the
        // settings root and never return or persist the complete decoded table.
        int close = xml.indexOf("</settings>");
        if (close < 0) throw new IOException();
        XmlPullParser parser = Xml.newPullParser();
        parser.setInput(new StringReader(xml.substring(0, close + "</settings>".length())));
        String found = null;
        int event;
        while ((event = parser.next()) != XmlPullParser.END_DOCUMENT) {
            if (event == XmlPullParser.START_TAG && "setting".equals(parser.getName())
                    && uid.equals(parser.getAttributeValue(null, "name"))
                    && expectedPackage.equals(parser.getAttributeValue(null, "package"))) {
                String value = parser.getAttributeValue(null, "value");
                if (found != null || value == null || !value.matches("[0-9a-f]{16}")) {
                    throw new IOException();
                }
                found = value;
            }
        }
        return found;
    }

    private static String readRandomSn(String xml) throws Exception {
        XmlPullParser parser = Xml.newPullParser();
        parser.setInput(new StringReader(xml));
        String found = null;
        int event;
        while ((event = parser.next()) != XmlPullParser.END_DOCUMENT) {
            if (event == XmlPullParser.START_TAG && "string".equals(parser.getName())
                    && "RANDOM_SN".equals(parser.getAttributeValue(null, "name"))) {
                String value = parser.nextText();
                if (found != null || value == null || !value.matches("[!-~]{40}")) {
                    throw new IOException();
                }
                found = value;
            }
        }
        return found;
    }

    private static void send(String socketName, String token, String status,
                             String androidId, String randomSn,
                             String[] additionalIds) {
        try (LocalSocket socket = new LocalSocket()) {
            socket.connect(new LocalSocketAddress(socketName,
                    LocalSocketAddress.Namespace.ABSTRACT));
            DataOutputStream output = new DataOutputStream(socket.getOutputStream());
            output.writeUTF(token);
            output.writeUTF(status);
            output.writeUTF(androidId);
            output.writeUTF(randomSn);
            for (String id : additionalIds) output.writeUTF(id);
            output.flush();
        } catch (Exception ignored) {
            // The owner app will time out. No diagnostic contains private values.
        }
    }

    private static final class StageFailure extends Exception {
        final String status;

        StageFailure(String status) {
            this.status = status;
        }
    }
}
