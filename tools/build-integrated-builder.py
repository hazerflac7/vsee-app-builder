"""Build the one-app V6 installer, including the tested PC-only relay code.

Run with Python from any directory. Requires the project Android SDK, Java,
Gradle wrapper, Apktool, and the local Android debug keystore used for previews.
The relay DEX comes from the checked-in smali, not an installed helper app.
"""

from __future__ import annotations

import hashlib
import os
from pathlib import Path
import shutil
import subprocess
import zipfile


PROJECT = Path(__file__).resolve().parents[1]
COLLECTOR = PROJECT / "heat-live-collector"
OUT = Path(os.environ.get("VSEE_BUILDER_OUTPUT",
                          PROJECT / "live" / "Vsee-App-Builder.apk"))
WORK = COLLECTOR / "build" / "integrated"
TOOLS = Path(os.environ.get("APKTOOLS_HOME", Path.home() / "APKTools"))
SDK = Path(os.environ.get("ANDROID_HOME", TOOLS / "android-sdk"))
BUILDER = COLLECTOR / "app" / "build" / "outputs" / "apk" / "debug" / "app-debug.apk"
HELPER_SOURCE = PROJECT / "pc-only-helper"
HELPER_DEX_SHA256 = "d37aa5cf58787c1186babaa9dc2335708ce54026ecb405de8fa5fd3e327973b4"
PREVIEW_SIGNER_SHA256 = "a5f732b71bdd37230b5305a45dc8e027065d6475a6e963486000b22763733d70"


def run(*args: object, cwd: Path | None = None) -> str:
    result = subprocess.run([str(arg) for arg in args], cwd=cwd, check=True,
                            capture_output=True, text=True)
    return result.stdout + result.stderr


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def main() -> None:
    WORK.mkdir(parents=True, exist_ok=True)
    build_tools = sorted(path for path in (SDK / "build-tools").iterdir()
                         if (path / "apksigner.bat").exists())[-1]
    java = shutil.which("java")
    if java is None:
        raise RuntimeError("Java is required")
    apktool = TOOLS / "bin" / "apktool.jar"
    keystore = Path.home() / ".android" / "debug.keystore"
    if not apktool.is_file() or not keystore.is_file():
        raise RuntimeError("Apktool or the preview signing keystore is missing")

    print(run(COLLECTOR / "gradlew.bat", ":app:assembleDebug", "--offline",
              cwd=COLLECTOR))
    helper_apk = WORK / "helper-unsigned.apk"
    print(run(java, "-jar", apktool, "b", HELPER_SOURCE, "-o", helper_apk))
    with zipfile.ZipFile(helper_apk) as helper:
        relay_dex = helper.read("classes.dex")
    if sha256(relay_dex) != HELPER_DEX_SHA256:
        raise RuntimeError("The embedded relay code differs from the tested source")

    unsigned = WORK / "builder-unsigned.apk"
    with zipfile.ZipFile(BUILDER) as original, zipfile.ZipFile(unsigned, "w") as merged:
        if "classes2.dex" in original.namelist():
            raise RuntimeError("Builder already has a second DEX; review packaging")
        for item in original.infolist():
            upper = item.filename.upper()
            if upper.startswith("META-INF/") and upper.endswith(
                    (".RSA", ".DSA", ".EC", ".SF")):
                continue
            merged.writestr(item, original.read(item.filename))
        merged.writestr("classes2.dex", relay_dex,
                        compress_type=zipfile.ZIP_STORED)

    aligned = WORK / "builder-aligned.apk"
    print(run(build_tools / "zipalign.exe", "-p", "-f", "4", unsigned, aligned))
    OUT.parent.mkdir(parents=True, exist_ok=True)
    print(run(build_tools / "apksigner.bat", "sign", "--v4-signing-enabled", "false",
              "--ks", keystore,
              "--ks-key-alias", "androiddebugkey", "--ks-pass", "pass:android",
              "--key-pass", "pass:android", "--out", OUT, aligned))
    verification = run(build_tools / "apksigner.bat", "verify", "--print-certs", OUT)
    if PREVIEW_SIGNER_SHA256 not in verification:
        OUT.unlink(missing_ok=True)
        raise RuntimeError("The preview signing identity changed")
    print(f"Ready: {OUT} ({OUT.stat().st_size} bytes, SHA-256 {sha256(OUT.read_bytes())})")


if __name__ == "__main__":
    main()
