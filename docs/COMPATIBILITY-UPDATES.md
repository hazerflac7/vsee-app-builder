# Signed compatibility updates

The builder includes known working versions. On **Check compatibility**, it also reads `compatibility/catalog.json` over HTTPS from this repository. The catalog is signed with a dedicated RSA key; the builder embeds only its public key. It accepts a catalog only when the signature, format, revision, package names, versions, template URLs, and size limits pass validation. A downloaded template must match the signed SHA-256 before it can be used. It is cached in the builder's private app storage. The builder does not send the box's profile, identifiers, accounts, or generated APKs to GitHub.

If the network is unavailable or an update fails validation, built-in versions continue to work. A new original version needs a signed catalog entry and a matching reviewed neutral template. The builder does not automatically invent patches for changed app code.

## Maintainer workflow for a later original update

1. Inspect the authorized original app update and prepare a neutral unsigned template. Check app behavior on an authorized device. Do not publish an owner-generated APK or a profile.
2. Add the reviewed template under `compatibility/templates/`, or reference an existing neutral template in the builder assets. Record its exact SHA-256, the original version/signature/content fingerprints, template entry count, and placeholder offsets in `compatibility/payload.json`.
3. Increase `revision` monotonically. Sign the payload with the offline private compatibility key using `python tools/sign-compatibility-catalog.py --payload compatibility/payload.json --key <private-key-path> --output compatibility/catalog.json`.
4. Verify that the signed payload matches the reviewed JSON and that the referenced template is published. Commit the catalog and template to this same repository. Owners then select **Check compatibility** again. The builder will fetch only templates needed for newly installed versions.

The private signing key is intentionally not part of Git. Losing it means existing builder installations cannot trust future catalogs from a replacement key; a new builder release would be required to rotate the public key. Keep the key in a secure backup.
