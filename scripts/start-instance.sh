#!/usr/bin/env bash
set -eu
source ./config.sh
gcloud compute instances start "$INSTANCE_NAME" --zone "$ZONE"
