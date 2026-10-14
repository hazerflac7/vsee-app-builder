# Build the integrated installer

This repository contains the current builder source, all six neutral APK templates, and the relay smali packaged into the builder. Each template hash is pinned in `heat-live-collector/template-manifest.json` or `heat-live-collector/five-template-manifest.json`.

Requirements on Windows: Python 3.11+, JDK 17+, Android SDK platform 34 with build tools, Gradle 8.11.1 (wrapper included), Android Gradle Plugin 8.9.2, and Apktool. The build script reads `ANDROID_HOME` and `APKTOOLS_HOME`; see its header and constants for the expected tool paths.

Run from the repository root:

```powershell
python tools/build-integrated-builder.py
```

It writes `live/Vsee-App-Builder.apk`. The script checks the relay DEX hash and the preview signer certificate. It uses the maintainer's existing Android debug keystore, which is **not** in this repository. An independent developer must use their own signing key and update the script's expected signer fingerprint before building. Such a build will have a different APK hash and is not the owner-tested release asset.

Do not upload generated owner APKs, owner profiles, signing keys, account data, or device logs. The `.gitignore` excludes common local outputs, but inspect every commit before publishing it.
