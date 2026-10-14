# Neutral Heat app templates

The adjacent `heat-live-template.apk` is an unsigned template with zero placeholders for the owner profile and two native certificate pins. Its SHA-256 and entry hashes are pinned in `heat-live-collector/template-manifest.json`. It cannot be installed as-is. The builder injects values on an authorized V6 and signs the result with an owner-generated key.
