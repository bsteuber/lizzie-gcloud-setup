#!/bin/bash
set -eu
# Check for CUDA and try to install.
if ! dpkg-query -W cuda-9-2; then
    echo "Installing CUDA 9.2"
    curl -LO https://developer.nvidia.com/compute/cuda/9.2/Prod/local_installers/cuda-repo-ubuntu1604-9-2-local_9.2.88-1_amd64.deb
    sudo dpkg -i ./cuda-repo-ubuntu1604-9-2-local_9.2.88-1_amd64.deb
    sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
    sudo apt-get update
    sudo apt-get install cuda-9-2 -y
    sudo nvidia-smi -pm 1
fi
if ! -f /leela/leelaz; then
    echo "Installing Leela Zero"
    sudo apt-get update
    sudo apt-get install make git g++ libboost-dev libboost-program-options-dev libopenblas-dev opencl-headers ocl-icd-libopencl1 ocl-icd-opencl-dev zlib1g-dev -y
    git clone https://github.com/bsteuber/leela-zero.git # this fork uses an up-to-date leela-zero master branch with the changes from https://github.com/featurecat/leela-zero
    cd leela-zero/src
    make
    cp leelaz /leela
    cd /leela
    ./download-best-network.sh
    ./download-elf-network.sh
fi
