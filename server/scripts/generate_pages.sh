#!/usr/bin/env bash
# Generate page illustrations and upload to GCS.
# Usage:
#   ./scripts/generate_pages.sh                          # all stories
#   ./scripts/generate_pages.sh --story cinderella       # one story only
#   HF_TOKEN=hf_xxx ./scripts/generate_pages.sh

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

echo "🎨  Generating page images..."
echo "☁   Will upload to gs://${GCS_BUCKET:-kidstories-images}/pages/"
echo ""

uv run python generate_page_images.py "$@"

echo ""
echo "✅  Done!"
