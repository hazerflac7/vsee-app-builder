package com.vseeheat.collector;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.KeyPair;
import java.security.SecureRandom;
import java.security.Signature;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

import javax.security.auth.x500.X500Principal;

/** Makes a long-lived, self-signed APK certificate without a third-party provider. */
final class OwnerCertificate {
    private static final byte[] SHA256_WITH_RSA = new byte[] {
            0x2a, (byte) 0x86, 0x48, (byte) 0x86, (byte) 0xf7, 0x0d,
            0x01, 0x01, 0x0b
    };

    private OwnerCertificate() {}

    static X509Certificate create(KeyPair pair) throws Exception {
        byte[] serialBytes = new byte[16];
        new SecureRandom().nextBytes(serialBytes);
        BigInteger serial = new BigInteger(1, serialBytes);
        if (serial.signum() == 0) serial = BigInteger.ONE;
        byte[] algorithm = sequence(tag(0x06, SHA256_WITH_RSA), tag(0x05, new byte[0]));
        byte[] name = new X500Principal("CN=VSee Heat Owner").getEncoded();
        long now = System.currentTimeMillis();
        Date before = new Date(now - 86_400_000L);
        Date after = new Date(now + 30L * 366 * 86_400_000L);
        byte[] validity = sequence(generalizedTime(before), generalizedTime(after));
        byte[] tbs = sequence(tag(0xa0, integer(BigInteger.valueOf(2))),
                integer(serial), algorithm, name, validity, name,
                pair.getPublic().getEncoded());
        Signature signer = Signature.getInstance("SHA256withRSA");
        signer.initSign(pair.getPrivate());
        signer.update(tbs);
        byte[] signature = signer.sign();
        byte[] bits = new byte[signature.length + 1];
        System.arraycopy(signature, 0, bits, 1, signature.length);
        byte[] certificate = sequence(tbs, algorithm, tag(0x03, bits));
        X509Certificate parsed = (X509Certificate) CertificateFactory.getInstance("X.509")
                .generateCertificate(new ByteArrayInputStream(certificate));
        parsed.verify(pair.getPublic());
        parsed.checkValidity(new Date(now));
        return parsed;
    }

    private static byte[] generalizedTime(Date date) {
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss'Z'", Locale.US);
        format.setTimeZone(TimeZone.getTimeZone("UTC"));
        return tag(0x18, format.format(date).getBytes(StandardCharsets.US_ASCII));
    }

    private static byte[] integer(BigInteger number) {
        return tag(0x02, number.toByteArray());
    }

    private static byte[] sequence(byte[]... items) {
        ByteArrayOutputStream value = new ByteArrayOutputStream();
        for (byte[] item : items) value.write(item, 0, item.length);
        return tag(0x30, value.toByteArray());
    }

    private static byte[] tag(int tag, byte[] value) {
        ByteArrayOutputStream result = new ByteArrayOutputStream();
        result.write(tag);
        if (value.length < 128) {
            result.write(value.length);
        } else {
            int width = 0;
            int copy = value.length;
            while (copy != 0) {
                width++;
                copy >>>= 8;
            }
            result.write(0x80 | width);
            for (int offset = (width - 1) * 8; offset >= 0; offset -= 8) {
                result.write(value.length >>> offset);
            }
        }
        result.write(value, 0, value.length);
        return result.toByteArray();
    }
}
