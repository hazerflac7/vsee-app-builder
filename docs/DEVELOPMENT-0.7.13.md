# 0.7.13 development notes

This candidate is for V6 and target-device testing. On 2026-10-16, its compatibility check matched all six installed original apps on a V6 Plus. The 0.7.12 release remains the last build with an owner-reported full export and target-device playback test.

After **Check compatibility**, the six tiles show which original apps match. Matching apps start selected; press OK on a tile to include or skip it. **Make APKs** is disabled when none are selected and saves only the selected APKs. Missing or changed unselected originals do not block the selection. The original Heat Live app is still required on the V6 to read the setup used by the builder, even when Heat Live is not selected for output.

Local checks passed: the Android build, integrated relay hash, installer signature, six embedded-template hashes, and APK resource compilation. All six branded templates retain byte-identical DEX files, libraries, and nonvisual assets from the 0.7.12 templates. The V6 export, selective builds, and target playback have **not yet been retested** for this candidate.

The release notes explicitly identify the missing device tests.
