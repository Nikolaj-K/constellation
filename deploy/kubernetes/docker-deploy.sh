#!/usr/bin/env bash

GOOGLE_PROJECT_ID="esoteric-helix-197319"
GOOGLE_CLUSTER_NAME="constellation-test"
DATE=$(date +%s)

# This is required because unless the YAML changes a value it won't trigger a redeploy to a new docker image..
IMAGE_TAG=$USER-$DATE
IMAGE=gcr.io/$GOOGLE_PROJECT_ID/constellationlabs/constellation:$IMAGE_TAG
IMAGE_LATEST=gcr.io/$GOOGLE_PROJECT_ID/constellationlabs/constellation:latest
echo "Using docker image: $IMAGE"

sbt docker:publishLocal
docker tag constellationlabs/constellation:latest $IMAGE
docker tag constellationlabs/constellation:latest $IMAGE_LATEST
gcloud docker -- push $IMAGE
gcloud docker -- push $IMAGE_LATEST