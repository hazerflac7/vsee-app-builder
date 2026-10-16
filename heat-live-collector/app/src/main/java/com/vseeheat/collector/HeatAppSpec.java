package com.vseeheat.collector;

/** Audited exact builds for the five additional Heat apps. */
final class HeatAppSpec {
    static final String LIB32 = "lib/armeabi-v7a/libjson.so";
    static final String LIB64 = "lib/arm64-v8a/libjson.so";
    static final String PROFILE = "assets/v6-owner-profile.json";
    static final String PLACEHOLDER_SHA256 =
            "a10a25533957d04d21db6c5aae100b047350908bbe890f0ed4d30b937195f345";
    static final String COMMON_LIB32_SHA256 =
            "103d3ed4b0a219520c3911c4c46f2ff2fce23200067b15687678e42c2b5c46d5";
    static final String COMMON_LIB64_SHA256 =
            "003e750fd452c52b1ee524a98b794637f9cc7f481a2da6c527e0324bc3415ad6";

    static final Spec[] OTHER = {
            new Spec("HeatVod", "com.google.heatvod", "6.9.6", 696, 23,
                    21_133_433L,
                    "a4a06bd3f11d222e50351f684f5f228fe7ebf649cb3523ea1b16e7462eea013b",
                    "66dd7a3f2e7bd79cfec1e7354c5313662c9fc5f440991f6703ae6a572ddab368",
                    "heatvod-template.apk",
                    "72bf86f5ac436d50615cb29ac7776e3dff4f6c953183c5d1e6fa25f6b3e157f1",
                    1536, COMMON_LIB32_SHA256, COMMON_LIB64_SHA256,
                    731_414, 1_006_780, "HeatVod-V6-Owner-6.9.6.apk"),
            new Spec("Vod Ultra", "com.google.heatvodultra", "3.8.2", 382, 29,
                    22_914_952L,
                    "c15b89f9f130cb2bcf7a420d66ee16c4b4aa1296b8162306d7e4a76bbb01bb6d",
                    "07d7fd1b17e1978053836dddb447e0c58870941c04f13ac4a38de2136fe8051d",
                    "heatvodultra-template.apk",
                    "1cf4d0b4719a97cbb9a456fd2e67f102a09da523b07c15189f644344899f135f",
                    1584, COMMON_LIB32_SHA256, COMMON_LIB64_SHA256,
                    731_414, 1_006_780, "Vod-Ultra-V6-Owner-3.8.2.apk"),
            new Spec("HeatLive Backup", "com.google.heatlivebackup", "4.7.8", 478, 26,
                    26_204_284L,
                    "1b4f664809fc2132f238a60ac54f3c89510f900bd2c4251518da5ebebbf82e3",
                    "6ec7993b241390005b2f1a085b2232ba4afcb9aa9f953b309488985213720085",
                    "heatlivebackup-template.apk",
                    "99657672ffca63f45414f48198bc34146a26ae0d26913078ce3103cd752969b2",
                    1716,
                    "eb277eeb1ffdaf382c13c8706b32dad07d56eace709a71eb0106f95357dded24",
                    "e65dbd9d99ce561df0adf2066b351db88f06e4dab2ae3e0d293eecda6031fdda",
                    731_461, 1_006_827, "HeatLive-Backup-V6-Owner-4.7.8.apk"),
            new Spec("Live Ultra", "com.google.liveultra", "5.8.0", 580, 29,
                    31_698_724L,
                    "3b1f55dce2a723e69f69aa3776cab5eb6f3c13fb5c4060f1d7b7b9906c60ac51",
                    "2ed23cb400b45bb15b152884172c40b744dbdf9d7ca366ffdad99ca3c40fa8fe",
                    "liveultra-template.apk",
                    "08ba332482a5b286e7314517e7e1a554635029008d2bce37de0b749005b9f21f",
                    1839, COMMON_LIB32_SHA256, COMMON_LIB64_SHA256,
                    731_414, 1_006_780, "Live-Ultra-V6-Owner-5.8.0.apk"),
            new Spec("Live Ultra+", "com.google.liveultraplus", "5.8.0", 580, 29,
                    31_564_780L,
                    "7ba52bf1b123fc36c2fe5e46e1b11129c15ae8d2a36198e5730795d81afc60bb",
                    "ae652a77ea6901c0dd7966cbf74617557123564b808ce4cc759455e121610a58",
                    "liveultraplus-template.apk",
                    "ed44a6bd403d71e979dfac9b6865939465ce141859ae646b224b279ebf60cd3c",
                    1844, COMMON_LIB32_SHA256, COMMON_LIB64_SHA256,
                    731_414, 1_006_780, "Live-Ultra-Plus-V6-Owner-5.8.0.apk")
    };

    private HeatAppSpec() {}

    static final class Spec {
        final String label;
        final String originalPackage;
        final String versionName;
        final long versionCode;
        final int minSdk;
        final long originalBytes;
        final String originalSha256;
        final String payloadSha256;
        final String templateAsset;
        final String templateSha256;
        final int templateEntries;
        final String lib32Sha256;
        final String lib64Sha256;
        final int pin32Offset;
        final int pin64Offset;
        final String outputName;

        Spec(String label, String originalPackage, String versionName, long versionCode,
             int minSdk, long originalBytes, String originalSha256, String payloadSha256,
             String templateAsset, String templateSha256, int templateEntries,
             String lib32Sha256, String lib64Sha256,
             int pin32Offset, int pin64Offset, String outputName) {
            this.label = label;
            this.originalPackage = originalPackage;
            this.versionName = versionName;
            this.versionCode = versionCode;
            this.minSdk = minSdk;
            this.originalBytes = originalBytes;
            this.originalSha256 = originalSha256;
            this.payloadSha256 = payloadSha256;
            this.templateAsset = templateAsset;
            this.templateSha256 = templateSha256;
            this.templateEntries = templateEntries;
            this.lib32Sha256 = lib32Sha256;
            this.lib64Sha256 = lib64Sha256;
            this.pin32Offset = pin32Offset;
            this.pin64Offset = pin64Offset;
            this.outputName = outputName;
        }
    }
}
