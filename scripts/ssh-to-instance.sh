#!/bin/bash
set -eu
source ./config.sh
gcloud compute ssh "$INSTANCE_NAME" --zone "$ZONE"
