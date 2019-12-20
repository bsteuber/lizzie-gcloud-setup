#!/usr/bin/env bash

# Tunes leela-zero for Lizzie on a gcloud compute instance
set -eu

source ./config.sh

./scripts/start-instance.sh
gcloud compute ssh "$INSTANCE_NAME" --zone "$ZONE" --command "cd /leela/ && ./leelaz -w best-network.gz --tune-only"
