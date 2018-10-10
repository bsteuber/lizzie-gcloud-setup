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
echo "Installing Leela Zero"
sudo apt-get update
sudo apt-get install make git g++ libboost-dev libboost-program-options-dev libopenblas-dev opencl-headers ocl-icd-libopencl1 ocl-icd-opencl-dev zlib1g-dev -y
rm -rf ./leela-zero
git clone -b next https://github.com/gcp/leela-zero.git
cd leela-zero/
git submodule update --init --recursive
cd src/
make
cp leelaz /leela
cd /leela
./download-best-network.sh
./download-elf-network.sh
