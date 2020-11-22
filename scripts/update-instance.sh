#!/usr/bin/env bash
set -eu

source ./config.sh

./scripts/start-instance.sh

echo "Waiting a few seconds for the instance to be ready..."
sleep 25
gcloud compute scp --zone "$ZONE" remote/* "$INSTANCE_NAME":/leela