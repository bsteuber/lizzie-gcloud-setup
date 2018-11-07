#!/usr/bin/env bash
set -eu
source ./config.sh
gcloud compute ssh "$INSTANCE_NAME" --zone "$ZONE" --command "/leela/download-best-network.sh"
