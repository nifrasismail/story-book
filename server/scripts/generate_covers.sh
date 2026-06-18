#!/usr/bin/env bash
# Generate cover images for all stories and upload to GCS.
# Usage:
#   ./scripts/generate_covers.sh                        # uses .env for HF_TOKEN
#   HF_TOKEN=hf_xxx ./scripts/generate_covers.sh
#   GCS_BUCKET=my-bucket ./scripts/generate_covers.sh  # override bucket

set -euo pipefail
cd "$(dirname "$0")/.."

# Load .env if present and HF_TOKEN not already set
if [[ -z "${HF_TOKEN:-}" && -f .env ]]; then
  export $(grep -v '^#' .env | xargs)
fi

if [[ -z "${HF_TOKEN:-}" ]]; then
  echo "❌  HF_TOKEN is required. Set it in .env or pass as HF_TOKEN=hf_xxx"
  exit 1
fi

echo "🎨  Generating cover images..."
echo "☁   Will upload to gs://${GCS_BUCKET:-kidstories-images}/covers/"
echo ""

uv run python generate_covers.py

echo ""
echo "✅  Done!"
