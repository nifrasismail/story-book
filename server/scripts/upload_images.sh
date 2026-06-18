#!/usr/bin/env bash
# Upload all locally generated images to GCS without regenerating.
# Useful if GCS bucket was wiped or you switched buckets.
# Usage:
#   ./scripts/upload_images.sh
#   GCS_BUCKET=my-bucket ./scripts/upload_images.sh

set -euo pipefail
cd "$(dirname "$0")/.."

BUCKET="${GCS_BUCKET:-kidstories-images}"

echo "☁   Uploading images to gs://${BUCKET}/"
echo ""

# Cover images
echo "📸  Covers..."
gsutil -m cp images/*.png "gs://${BUCKET}/covers/" 2>&1

# Page images
echo ""
echo "📖  Page illustrations..."
gsutil -m cp -r images/pages "gs://${BUCKET}/" 2>&1

echo ""
echo "✅  All images uploaded to gs://${BUCKET}/"
