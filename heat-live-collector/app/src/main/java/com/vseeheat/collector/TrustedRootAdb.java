package com.vseeheat.collector;

import android.net.LocalSocket;
import android.net.LocalSocketAddress;
import android.system.Os;
import android.system.OsConstants;
import android.system.StructStat;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.Properties;
import java.util.concurrent.TimeUnit;

/** Finds only the active journaled V6 helper socket, then checks the root peer. */
final class TrustedRootAdb {
    private static final String ORIGINAL_BASE = "/data/system/v6-root-check";
    private static final String PC_ONLY_BASE = "/data/system/v6-pc-only-adb";
    private static final String LISTEN_PROPERTY = "service.adb.listen_addrs";
    private static final String ROOT_PROPERTY = "service.adb.root";
    private static final String BOOT_ID = "/proc/sys/kernel/random/boot_id";
    private final String socketPath;

    private TrustedRootAdb(String socketPath) {
        this.socketPath = socketPath;
    }

    static TrustedRootAdb findActive() throws IOException {
        String target = commandOutput("/system/bin/getprop", LISTEN_PROPERTY).trim();
        if (!target.startsWith("localfilesystem:")) throw new IOException();
        String path = target.substring("localfilesystem:".length());
        String base;
        if (path.matches(ORIGINAL_BASE + "/t[0-9a-f]{32}/a")) {
            base = ORIGINAL_BASE;
        } else if (path.matches(PC_ONLY_BASE + "/t[0-9a-f]{32}/a")) {
            base = PC_ONLY_BASE;
        } else {
            throw new IOException();
        }
        // These directories and journal can be written only by the trusted
        // system UID. Reject links and loose permissions before reading state.
        checkOwnedDirectory(new File(base));
        checkOwnedDirectory(new File(path).getParentFile());
        File journal = new File(base, "trial.properties");
        StructStat state;
        try {
            state = Os.lstat(journal.getPath());
        } catch (Exception ignored) {
            throw new IOException();
        }
        if (!OsConstants.S_ISREG(state.st_mode) || state.st_uid != 1000
                || (state.st_mode & 0777) != 0600) throw new IOException();
        Properties saved = new Properties();
        try (InputStream input = new FileInputStream(journal)) {
            saved.load(new java.io.ByteArrayInputStream(readBounded(input, 4096)));
        }
        if (!path.equals(saved.getProperty("socket"))
                || !target.equals(saved.getProperty("target"))
                || saved.getProperty("root") == null
                || saved.getProperty("listen") == null
                || !commandOutput("/system/bin/cat", BOOT_ID).trim()
                        .equals(saved.getProperty("boot"))
                || !"1".equals(commandOutput("/system/bin/getprop", ROOT_PROPERTY).trim())) {
            throw new IOException();
        }
        return new TrustedRootAdb(path);
    }

    void verifyRootShell() throws IOException {
        if (!"0".equals(run(Read.UID).trim())) throw new IOException();
    }

    String readSsaid() throws IOException {
        return run(Read.SSAID);
    }

    String readPreference() throws IOException {
        return run(Read.PREFERENCE);
    }

    private String run(Read type) throws IOException {
        try (LocalSocket socket = new LocalSocket()) {
            socket.connect(new LocalSocketAddress(socketPath,
                    LocalSocketAddress.Namespace.FILESYSTEM));
            socket.setSoTimeout(6000);
            if (socket.getPeerCredentials().getUid() != 0) throw new IOException();
            switch (type) {
                case UID:
                    return PrivateAdbWire.readRootUid(socket.getInputStream(),
                            socket.getOutputStream());
                case SSAID:
                    return PrivateAdbWire.readSsaid(socket.getInputStream(),
                            socket.getOutputStream());
                case PREFERENCE:
                    return PrivateAdbWire.readPreference(socket.getInputStream(),
                            socket.getOutputStream());
                default:
                    throw new IOException();
            }
        }
    }

    private static void checkOwnedDirectory(File directory) throws IOException {
        android.system.StructStat state;
        try {
            state = Os.lstat(directory.getPath());
        } catch (Exception ignored) {
            throw new IOException();
        }
        if (!OsConstants.S_ISDIR(state.st_mode) || state.st_uid != 1000
                || (state.st_mode & 0777) != 0700) throw new IOException();
    }

    private static String commandOutput(String executable, String argument) throws IOException {
        java.lang.Process process = null;
        try {
            process = new ProcessBuilder(executable, argument).redirectErrorStream(true).start();
            byte[] data = readBounded(process.getInputStream(), 256);
            if (!process.waitFor(2000, TimeUnit.MILLISECONDS) || process.exitValue() != 0) {
                throw new IOException();
            }
            return new String(data, StandardCharsets.UTF_8);
        } catch (InterruptedException ignored) {
            Thread.currentThread().interrupt();
            throw new IOException();
        } finally {
            if (process != null) process.destroy();
        }
    }

    private static byte[] readBounded(InputStream input, int maximum) throws IOException {
        ByteArrayOutputStream output = new ByteArrayOutputStream();
        byte[] block = new byte[512];
        int size;
        while ((size = input.read(block)) >= 0) {
            if (output.size() + size > maximum) throw new IOException();
            output.write(block, 0, size);
        }
        return output.toByteArray();
    }

    private enum Read { UID, SSAID, PREFERENCE }
}
