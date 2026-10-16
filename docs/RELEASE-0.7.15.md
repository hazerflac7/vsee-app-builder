# Vsee App Builder 0.7.15

## What's new

- Recognizes original Heat Live 5.9.5 while retaining the built-in 5.9.4 option.
- **Check compatibility** can fetch a signed catalog of reviewed original-app versions and their matching neutral templates. Existing built-in versions work offline. Owners can receive later reviewed compatibility updates without installing another builder APK.
- A changed app with no reviewed entry stops with a clear message instead of producing an unverified APK.

## What this does not automate

This does not rewrite arbitrary future app updates on the box. A maintainer must still inspect an updated original, prepare and validate its neutral template, then publish a signed catalog entry. The catalog and template contain no box-specific owner profile. See [compatibility maintenance](COMPATIBILITY-UPDATES.md).

## Verification

The integrated Android build, package signature, and embedded template checks passed. On a V6 Plus with original Heat Live 5.9.5, **Check compatibility** matched all six original apps. Selecting Heat Live alone saved one 5.9.5 APK to Downloads. That APK passed signature and package checks, installed, and opened on the source Plus. At the owner's request, a separate-device playback test was skipped. A 5.9.4 regression build and a future-version catalog download have not yet been tested on a box.

Generated owner APKs contain information tied to the owner's box and must stay private.
