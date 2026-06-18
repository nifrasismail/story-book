#!/usr/bin/env bash
# Build and deploy the API to Cloud Run.
# Usage:
#   ./scripts/deploy.sh
#   GCP_PROJECT=my-project ./scripts/deploy.sh

set -euo pipefail
cd "$(dirname "$0")/.."

GCP_PROJECT="${GCP_PROJECT:-storybook-kids-499212}"
REGION="${REGION:-us-central1}"
SERVICE="${SERVICE:-kidstories-api}"
IMAGE="gcr.io/${GCP_PROJECT}/${SERVICE}:latest"

echo "🏗   Building and pushing image..."
gcloud builds submit \
  --tag "$IMAGE" \
  --project "$GCP_PROJECT"

echo ""
echo "🚀  Deploying to Cloud Run..."
gcloud run deploy "$SERVICE" \
  --image "$IMAGE" \
  --region "$REGION" \
  --platform managed \
  --allow-unauthenticated \
  --memory 512Mi \
  --cpu 1 \
  --min-instances 1 \
  --max-instances 10 \
  --set-env-vars GCS_IMAGES_BASE=https://storage.googleapis.com/kidstories-images \
  --set-secrets SUPABASE_URL=SUPABASE_URL:latest,SUPABASE_SERVICE_KEY=SUPABASE_SERVICE_KEY:latest,REVENUECAT_WEBHOOK_SECRET=REVENUECAT_WEBHOOK_SECRET:latest \
  --project "$GCP_PROJECT"

echo ""
echo "✅  Deployed! Service URL:"
gcloud run services describe "$SERVICE" \
  --region "$REGION" \
  --project "$GCP_PROJECT" \
  --format "value(status.url)"
