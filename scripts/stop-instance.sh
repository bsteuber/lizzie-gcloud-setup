#!/bin/bash
set -eu
source ./config.sh
gcloud compute instances stop "$INSTANCE_NAME" --zone "$ZONE"
