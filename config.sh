#!/bin/bash

# Configure these parameters according to your needs.
# See https://cloud.google.com/compute/docs/gpus/add-gpus#create-new-gpu-instance for more details.

# the name of the created instance
INSTANCE_NAME=lizzie

# can be either "best" or "elf" for the facebook opengo converted weights (currently stronger, slower)
NETWORK=elf

# pick a nearby zone that has the gpu you want - see https://cloud.google.com/compute/docs/gpus/
ZONE=europe-west4-a

# can be k80, p100, v100 - see README.md
GPU_TYPE=nvidia-tesla-p100

# the number of gpus (one should usually be enough)
GPU_COUNT=1

# the number of cpus you seem fit for your gpu - try powers of 2 or consult https://cloud.google.com/compute/docs/machine-types
CPU_COUNT=8

# 10GB should be plenty of space for just leela zero.. You might get away with less
DISK_SIZE=10GB

# You could configure a custom RAM amount here - see https://cloud.google.com/compute/docs/machine-types. But normally just leave it..
MACHINE_TYPE="n1-standard-$CPU_COUNT"

# Only touch these if you know what you're doing. You will need to adapt the setup script for other Linux distributions.
IMAGE_FAMILY=ubuntu-1604-lts
IMAGE_PROJECT=ubuntu-os-cloud
