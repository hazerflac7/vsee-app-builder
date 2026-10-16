# 0.7.13 development notes

This candidate is for V6 and target-device testing. The published 0.7.12 release remains the last owner-tested build.

After **Check compatibility**, the six tiles show which original apps match. Matching apps start selected; press OK on a tile to include or skip it. **Make APKs** is disabled when none are selected and saves only the selected APKs. Missing or changed unselected originals do not block the selection. The original Heat Live app is still required on the V6 to read the setup used by the builder, even when Heat Live is not selected for output.

Generated apps keep their normal names. Their launcher icons and Android TV banners include a small **TORR3NT** marker. The marker is vector artwork and does not change the apps' code, libraries, or owner-profile placeholder.

Local checks passed: the Android build, integrated relay hash, installer signature, six embedded-template hashes, and APK resource compilation. All six branded templates retain byte-identical DEX files, libraries, and nonvisual assets from the 0.7.12 templates. The V6 export, selective builds, launcher appearance, and target playback have **not yet been tested** for this candidate.

The release notes explicitly identify the missing device tests. The repository remains private while the source is hidden from public view.
