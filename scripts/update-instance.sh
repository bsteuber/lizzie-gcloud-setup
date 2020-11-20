#!/usr/bin/env bash
set -eu

source ./config.sh

./scripts/start-instance.sh
gcloud compute scp --zone "$ZONE" remote/* "$INSTANCE_NAME":/leela