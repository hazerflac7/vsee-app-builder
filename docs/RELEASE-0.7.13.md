# Vsee App Builder 0.7.13

## What's new

- After **Check compatibility**, each matching app appears as a selected tile. Press OK on a tile to include or skip that app.
- **Make APKs** exports only the selected compatible apps. Missing or changed apps that are not selected do not block a build.
- The button stays disabled when no compatible apps are selected.

## Status

The Android build, integrated package, signature, embedded template hashes, and APK resource compilation passed local checks. On 2026-10-16, the installer was installed on a V6 Plus and **Check compatibility** reported all six original apps as matching. The owner accepted the first-run notice. The V6 export, selected-app flow, and target-device playback have not yet been retested for 0.7.13. The previous 0.7.12 release was owner-tested on a factory-reset V6 and 2017 Shield.

Heat Live must still be installed on the V6 to read the owner setup even if it is not selected for export. Keep generated APKs private because they contain information tied to the owner's box.
