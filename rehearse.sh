#!/usr/bin/env bash
# Instructor rehearsal: run in Cloud Shell from this folder.
#   bash rehearse.sh YOUR-PROJECT-ID
set -euo pipefail
PROJECT_ID="${1:?usage: bash rehearse.sh YOUR-PROJECT-ID}"
REGION=us-central1

gcloud config set project "$PROJECT_ID"
gcloud services enable run.googleapis.com cloudbuild.googleapis.com artifactregistry.googleapis.com

# Pre-empt the most common source-deploy failure: the build service account lacking permission.
PROJECT_NUMBER=$(gcloud projects describe "$PROJECT_ID" --format='value(projectNumber)')
gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:${PROJECT_NUMBER}-compute@developer.gserviceaccount.com" \
  --role="roles/run.builder" --condition=None >/dev/null

gcloud run deploy hello --source . --region="$REGION" \
  --allow-unauthenticated --max-instances=2 --quiet

URL=$(gcloud run services describe hello --region="$REGION" --format='value(status.url)')
curl -fsS "$URL/healthz" && echo
echo "Live at: $URL  (leave it running for the class hook)"
