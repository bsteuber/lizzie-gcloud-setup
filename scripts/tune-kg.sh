#!/usr/bin/env bash

#Asks katago to tune for the number of threads. From the terminal, the recommendation can be applied to the gtp_example.cfg file manually
set -eu

source ./config.sh

gcloud compute ssh "$INSTANCE_NAME" --zone "$ZONE" --command "cd /leela/ && ./katago benchmark -model $KGNET.bin.gz -config gtp_example.cfg -time $KGTIME -visits $KGVISITS"
