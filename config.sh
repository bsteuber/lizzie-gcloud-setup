#!/bin/bash

# Configure these parameters according to your needs.
# See https://cloud.google.com/compute/docs/gpus/add-gpus#create-new-gpu-instance for more details.

# the name of the created instance
INSTANCE_NAME=leelazero-v100

# can be either "best" or "elf" for the facebook opengo converted weights (currently stronger, slower)
NETWORK=best
# NETWORK=elf

# choose the katago network (20,30 or 40 block) from the June 2020 run. Note no space allowed
KGNET=b40s509
# KGNET=30s482
# KGNET=20s530

# amount of time katago is expected to analyse each position for in seconds,for tuning purposes
# on my instance when this is 5, then 16 threads are recommended, and when 60, then 160 threads
KGTIME=60

# larger for more accuratate tuning but takes longer to tune
KGVISITS=2000

# the config file as katago has lots of parameters
KGCONFIG=gtp_example

# pick a nearby zone that has the gpu you want - see https://cloud.google.com/compute/docs/gpus/
ZONE=europe-west4-a

# can be k80, p100, v100 - see README.md
GPU_TYPE=nvidia-tesla-v100

# the number of gpus (one should usually be enough)
GPU_COUNT=1

# the number of cpus you seem fit for your gpu - should be an even number
CPU_COUNT=6

# 15GB should be plenty of space for just leela zero.. You might get away with less
DISK_SIZE=15GB

# Set the RAM here - not sure how much is needed for leela
MEMORY=10GB

# Only touch these if you know what you're doing. You will need to adapt the setup script for other Linux distributions.
IMAGE_FAMILY=ubuntu-1804-lts
IMAGE_PROJECT=ubuntu-os-cloud

# Prefix for shell aliases
ALIAS_PREFIX=v100-
