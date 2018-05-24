#!/bin/bash

# Installs leela-zero for Lizzie on a gcloud compute instance
set -eu

source ./config.sh

gcloud compute ssh "$INSTANCE_NAME" --zone "$ZONE" --command "sudo mkdir -p /leela && sudo chmod o+rw /leela"
gcloud compute scp --zone "$ZONE" remote/*.sh "$INSTANCE_NAME":/leela/
gcloud compute ssh "$INSTANCE_NAME" --zone "$ZONE" --command "/leela/setup.sh"
gcloud compute ssh "$INSTANCE_NAME" --zone "$ZONE" --command "cd /leela/ && ./leelaz -w $NETWORK-network.gz -t $CPU_COUNT --tune-only"
