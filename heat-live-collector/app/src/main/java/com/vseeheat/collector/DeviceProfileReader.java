package com.vseeheat.collector;

import android.os.Build;

import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.InputStream;
import java.net.NetworkInterface;
import java.nio.charset.StandardCharsets;
import java.util.Locale;
import java.util.concurrent.TimeUnit;

/** Mirrors the exact original Heat Live 5.9.4 identity getters on this V6. */
final class DeviceProfileReader {
    private DeviceProfileReader() {}

    static JSONObject complete(JSONObject partial) throws Exception {
        JSONObject profile = new JSONObject();
        profile.put("ethernetMac", ethernetMac());
        profile.put("cpuId", cpuId());
        profile.put("serial", serial());
        profile.put("androidId", partial.getString("androidId"));
        profile.put("brand", Build.BRAND);
        profile.put("manufacturer", Build.MANUFACTURER);
        profile.put("model", Build.MODEL);
        profile.put("release", Build.VERSION.RELEASE);
        profile.put("firmwareVersion", property("ro.fw.pck.version"));
        profile.put("clapVersion", property("persist.clap.sw.ver"));
        profile.put("randomSn", partial.getString("randomSn"));
        validate(profile);
        return profile;
    }

    static void validate(JSONObject value) throws Exception {
        if (!value.getString("ethernetMac").matches("[0-9a-f]{2}(:[0-9a-f]{2}){5}")
                || !value.getString("cpuId").matches("[0-9a-fA-F]{32}")
                || !value.getString("serial").matches("[!-~]{0,64}")
                || !value.getString("androidId").matches("[0-9a-f]{16}")
                || !value.getString("brand").matches("[!-~]{1,64}")
                || !"chke".equals(value.getString("manufacturer"))
                || !"V6-Pro".equals(value.getString("model"))
                || !value.getString("release").matches("[0-9.]{1,16}")
                || !value.getString("firmwareVersion").matches("[!-~]{0,128}")
                || !value.getString("clapVersion").matches("[!-~]{0,128}")
                || !value.getString("randomSn").matches("[!-~]{40}")) {
            throw new IllegalStateException();
        }
    }

    private static String ethernetMac() throws Exception {
        NetworkInterface ethernet = NetworkInterface.getByName("eth0");
        if (ethernet != null) {
            byte[] address = ethernet.getHardwareAddress();
            if (address != null && address.length == 6) {
                StringBuilder value = new StringBuilder(17);
                for (byte item : address) {
                    if (value.length() > 0) value.append(':');
                    value.append(String.format(Locale.US, "%02x", item & 0xff));
                }
                return value.toString();
            }
        }
        return readFirstLine("/sys/class/net/eth0/address", 128).toLowerCase(Locale.US);
    }

    private static String cpuId() throws Exception {
        String value = keyedLine("/proc/cpuinfo", "Serial", 256 * 1024);
        if (value == null) value = keyedLine("/sys/class/sunxi_info/sys_info",
                "sunxi_serial", 64 * 1024);
        if (value == null) throw new IllegalStateException();
        int colon = value.indexOf(':');
        return value.substring(colon + 1).trim();
    }

    private static String serial() {
        try {
            String value = Build.getSerial();
            return value == null ? "" : value.trim();
        } catch (Exception ignored) {
            return "";
        }
    }

    private static String property(String key) throws Exception {
        java.lang.Process child = null;
        try {
            child = new ProcessBuilder("/system/bin/getprop", key).start();
            byte[] data = readBounded(child.getInputStream(), 128);
            if (!child.waitFor(2000, TimeUnit.MILLISECONDS) || child.exitValue() != 0) {
                throw new IllegalStateException();
            }
            return new String(data, StandardCharsets.UTF_8).trim();
        } finally {
            if (child != null) child.destroy();
        }
    }

    private static String keyedLine(String path, String prefix, int maximum) throws Exception {
        int total = 0;
        try (BufferedReader reader = new BufferedReader(new FileReader(path))) {
            String line;
            while ((line = reader.readLine()) != null) {
                total += line.length() + 1;
                if (total > maximum) throw new IllegalStateException();
                if (line.startsWith(prefix)) return line.trim();
            }
        }
        return null;
    }

    private static String readFirstLine(String path, int maximum) throws Exception {
        try (BufferedReader reader = new BufferedReader(new FileReader(path))) {
            String value = reader.readLine();
            if (value == null || value.length() > maximum) throw new IllegalStateException();
            return value.trim();
        }
    }

    private static byte[] readBounded(InputStream input, int maximum) throws Exception {
        byte[] buffer = new byte[maximum + 1];
        int used = 0;
        int count;
        while ((count = input.read(buffer, used, buffer.length - used)) != -1) {
            used += count;
            if (used > maximum) throw new IllegalStateException();
            if (used == buffer.length) throw new IllegalStateException();
        }
        return java.util.Arrays.copyOf(buffer, used);
    }
}
