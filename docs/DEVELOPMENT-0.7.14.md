# Vsee App Builder 0.7.14 local build

This local build adds exact-match support for original Heat Live 5.9.5
while retaining 5.9.4 support. It selects the matching Heat Live template and
recollects the sealed owner profile when the installed original version
changes. The other five supported app versions are unchanged.

## Verification so far

- The Android build and integrated installer signature checks passed.
- On a V6 Plus with original Heat Live 5.9.5, Check compatibility matched all
  six installed originals.
- Selecting only Heat Live saved one 5.9.5 APK to Downloads. The resulting APK
  has a valid signature, the expected package and version, and exactly three
  changed payload entries compared with its neutral template: the local owner
  profile and the two certificate pins.
- The generated APK installed and opened on the source V6 Plus. No fatal
  exception was observed during this check.

At the owner's request, playback on a separate Android TV device was skipped
for this update. A 5.9.4 regression build has not been run. The 0.7.14 APK is
available in the local live folder; these untested paths must not be described
as verified. This note does not claim a public release.

Generated owner APKs contain box-specific information and must not be
committed to this repository.
