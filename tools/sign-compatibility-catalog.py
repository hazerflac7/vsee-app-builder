"""Sign a reviewed compatibility payload without publishing the private key."""

import argparse
import base64
import json
from pathlib import Path

from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric import padding


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--payload", type=Path, required=True)
    parser.add_argument("--key", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()

    payload = json.loads(args.payload.read_text(encoding="utf-8"))
    if payload.get("format") != 1 or not isinstance(payload.get("entries"), list):
        raise SystemExit("Unsupported compatibility payload")
    compact = json.dumps(payload, sort_keys=True, separators=(",", ":"),
                         ensure_ascii=False).encode("utf-8")
    if len(compact) > 64 * 1024:
        raise SystemExit("Compatibility payload exceeds 64 KiB")
    private_key = serialization.load_pem_private_key(args.key.read_bytes(), password=None)
    signature = private_key.sign(compact, padding.PKCS1v15(), hashes.SHA256())
    envelope = {
        "payload": base64.b64encode(compact).decode("ascii"),
        "signature": base64.b64encode(signature).decode("ascii"),
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(envelope, separators=(",", ":")) + "\n",
                           encoding="utf-8")
    print(f"Signed revision {payload['revision']} with {len(payload['entries'])} entries")


if __name__ == "__main__":
    main()
