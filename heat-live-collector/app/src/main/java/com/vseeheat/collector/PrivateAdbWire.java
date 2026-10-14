package com.vseeheat.collector;

import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;

/** Minimal ADB framing for fixed read-only commands on a verified local root socket. */
final class PrivateAdbWire {
    private static final int AUTH = 1213486401;
    private static final int CLSE = 1163086915;
    private static final int CNXN = 1314410051;
    private static final int OKAY = 1497451343;
    private static final int OPEN = 1313165391;
    private static final int WRTE = 1163154007;
    private static final int MAX_PACKET = 65_536;
    private static final String ROOT_UID_COMMAND = "/system/bin/id -u";
    private static final String SSAID_COMMAND = "/system/bin/abx2xml "
            + "/data/system/users/0/settings_ssaid.xml /dev/stdout";
    private static final String PREF_COMMAND = "/system/bin/cat "
            + "/data/user/0/com.google.heatlive/shared_prefs/data.xml";

    private PrivateAdbWire() {}

    static String readRootUid(InputStream input, OutputStream output) throws IOException {
        return shell(input, output, ROOT_UID_COMMAND, 32);
    }

    static String readSsaid(InputStream input, OutputStream output) throws IOException {
        return shell(input, output, SSAID_COMMAND, 512 * 1024);
    }

    static String readPreference(InputStream input, OutputStream output) throws IOException {
        return shell(input, output, PREF_COMMAND, 4096);
    }

    private static String shell(InputStream input, OutputStream output,
                                String fixedCommand, int maximum) throws IOException {
        DataInputStream packets = new DataInputStream(input);
        send(output, CNXN, 16_777_216, 4096,
                "host::\u0000".getBytes(StandardCharsets.UTF_8));
        Packet hello = receive(packets);
        if (hello.command == AUTH || hello.command != CNXN || hello.a < 16_777_216) {
            throw new IOException();
        }
        String command = "shell:" + fixedCommand + "\u0000";
        send(output, OPEN, 1, 0, command.getBytes(StandardCharsets.UTF_8));
        ByteArrayOutputStream response = new ByteArrayOutputStream();
        int remoteId = 0;
        for (int count = 0; count < 512; count++) {
            Packet packet = receive(packets);
            if (packet.command == CLSE && packet.b == 1) {
                if (remoteId == 0 || packet.a != remoteId) throw new IOException();
                send(output, CLSE, 1, remoteId, new byte[0]);
                return response.toString("UTF-8");
            }
            if (packet.b != 1 || packet.a == 0) throw new IOException();
            if (packet.command == OKAY && remoteId == 0) {
                remoteId = packet.a;
            } else if (packet.command == WRTE && remoteId == packet.a) {
                if (response.size() + packet.data.length > maximum) throw new IOException();
                response.write(packet.data);
                send(output, OKAY, 1, remoteId, new byte[0]);
            } else {
                throw new IOException();
            }
        }
        throw new IOException();
    }

    private static void send(OutputStream output, int command, int arg0, int arg1,
                             byte[] data) throws IOException {
        int checksum = 0;
        for (byte value : data) checksum += value & 0xff;
        writeInt(output, command);
        writeInt(output, arg0);
        writeInt(output, arg1);
        writeInt(output, data.length);
        writeInt(output, checksum);
        writeInt(output, ~command);
        output.write(data);
        output.flush();
    }

    private static Packet receive(DataInputStream input) throws IOException {
        Packet packet = new Packet();
        packet.command = Integer.reverseBytes(input.readInt());
        packet.a = Integer.reverseBytes(input.readInt());
        packet.b = Integer.reverseBytes(input.readInt());
        int length = Integer.reverseBytes(input.readInt());
        int checksum = Integer.reverseBytes(input.readInt());
        int magic = Integer.reverseBytes(input.readInt());
        if (magic != ~packet.command || length < 0 || length > MAX_PACKET) {
            throw new IOException();
        }
        packet.data = new byte[length];
        input.readFully(packet.data);
        int actual = 0;
        for (byte value : packet.data) actual += value & 0xff;
        if (actual != checksum) throw new IOException();
        return packet;
    }

    private static void writeInt(OutputStream output, int value) throws IOException {
        for (int byteIndex = 0; byteIndex < 4; byteIndex++) {
            output.write(value >>> (byteIndex * 8));
        }
    }

    private static final class Packet {
        int command;
        int a;
        int b;
        byte[] data;
    }
}
