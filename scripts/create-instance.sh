#!/usr/bin/env bash

# Sets up a new gcloud gpu instance

set -eu

source ./config.sh

echo "gcloud compute instances create $INSTANCE_NAME"
echo "       --custom-cpu $CPU_COUNT"
echo "       --custom-memory $MEMORY"
echo "       --zone $ZONE"
echo "       --accelerator type=$GPU_TYPE,count=$GPU_COUNT"
echo "       --boot-disk-size $DISK_SIZE"
echo "       --image-family=$IMAGE_FAMILY"
echo "       --image-project=$IMAGE_PROJECT"
echo "       --maintenance-policy=TERMINATE"
echo "       $PREEMPTIBLE"

# Usually no need to touch this
gcloud compute instances create "$INSTANCE_NAME" \
       --custom-cpu "$CPU_COUNT" \
       --custom-memory "$MEMORY" \
       --zone "$ZONE" \
       --accelerator type="$GPU_TYPE",count="$GPU_COUNT" \
       --boot-disk-size "$DISK_SIZE" \
       --image-family="$IMAGE_FAMILY" \
       --image-project="$IMAGE_PROJECT" \
       --maintenance-policy=TERMINATE \
       $PREEMPTIBLE
