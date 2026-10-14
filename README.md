# Vsee App Builder

**Vsee App Builder** is an Android TV app by TORR3NT's Tech. On a compatible V6 box, it checks six installed original apps and makes six APKs in a dated folder in Downloads. The owner can copy those files to another Android TV device and install them there.

The screen has two actions: **Check compatibility** and **Make APKs**. The builder starts the temporary access it needs during the build. It does not install the generated APKs on the other device.

## Current status

Version **0.7.12-design-preview** (`versionCode` 19) was tested by the owner on one factory-reset V6 and a 2017 Shield. The owner reported that all six APKs were exported and worked on the Shield. This is one reported device pair, not a guarantee for other boxes, firmware, app versions, or future service changes.

Download the tested installer from the [0.7.12 release](https://github.com/torrent329/vsee-app-builder/releases/tag/v0.7.12). Its SHA-256 is `11a2063ebc2ae0cd0f3b64aa09ece3d532e24123cdd2e2f600761a0e71ae8eba`. The 158 MB APK is a release asset rather than a Git file. Verify its hash before installing it.

## Use on your own box

1. Use a V6 with the six supported original apps installed and working. See [supported versions](docs/SUPPORTED-APPS.md).
2. Install the builder APK on that V6 and read the first-launch testing notice. Continue only if you agree.
3. Select **Check compatibility**. If the TV remote merely highlights the button, press OK again.
4. Once all six apps match, select **Make APKs**. Wait for **Your six APKs are ready**.
5. Open the dated `Vsee-Apps-...` folder in Downloads. Copy the generated APKs to your other device and install them with its normal installer.

The generated APKs contain information from the owner's V6. **Do not upload or share them.** A new signing key after a factory reset may require uninstalling older generated apps before installing replacements; that can erase their app data.

This tool is for authorized testing. Using modified apps may affect service or account access. Read the [testing notice](docs/TESTING-NOTICE.md).

## Source and builds

`heat-live-collector/` holds the current builder source and six neutral app templates. `pc-only-helper/` holds the relay code that is packaged inside the builder. `tools/build-integrated-builder.py` assembles, merges, aligns, signs, and checks the installer. See [building from source](docs/BUILDING.md). A plain Gradle build omits the relay and is not the complete installer.

This repository starts with a fresh history of the current version. It does not include owner profiles, generated owner APKs, private signing keys, device logs, or older prototypes.

## License and third-party material

Original code and documentation authored by TORR3NT's Tech are under [Apache License 2.0](LICENSE). The included Heat/VSee templates, generated app contents, and any separately owned helper material are **not** granted under that license. See [third-party notices](THIRD_PARTY_NOTICES.md). The project owner reports permission to publish the included material; downstream users must confirm any rights needed to reuse or redistribute it.
