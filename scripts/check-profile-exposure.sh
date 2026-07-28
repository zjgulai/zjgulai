#!/usr/bin/env bash
set -euo pipefail

if rg -n -i 'momcozy|lute|路特' README.md assets/readme scripts \
  --glob '!scripts/check-profile-exposure.sh'; then
  echo "Forbidden profile keyword detected." >&2
  exit 1
fi

if find assets/readme -type f -print | rg -i 'momcozy|lute|路特'; then
  echo "Forbidden profile keyword detected in an asset path." >&2
  exit 1
fi

echo "Profile source exposure check passed."
