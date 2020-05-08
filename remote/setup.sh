#!/bin/bash
set -eu

echo "Installing cuda-10.1 and libcudnn7"
# https://askubuntu.com/questions/1077061/how-do-i-install-nvidia-and-cuda-drivers-into-ubuntu
sudo rm -f /etc/apt/sources.list.d/cuda*
sudo apt update
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt-key adv --fetch-keys  http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
sudo bash -c 'echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list'
sudo bash -c 'echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda_learn.list'
sudo apt update
sudo apt install cuda-10-1 -y
sudo apt install libcudnn7 -y

echo "Installing recent cmake"
sudo apt remove cmake -y
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | sudo apt-key add -
sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main'
sudo apt-get update
sudo apt-get install cmake -y


echo "Installing Leela Zero"
sudo apt-get install make git libboost-dev libboost-filesystem-dev libboost-program-options-dev opencl-headers ocl-icd-libopencl1 ocl-icd-opencl-dev zlib1g-dev -y
sudo apt autoremove -y
rm -rf ./leela-zero
git clone -b next https://github.com/gcp/leela-zero.git
cd leela-zero/
git submodule update --init --recursive

# Need at least gcc 8.
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get install gcc-9 g++-9 -y

mkdir build && cd build
cmake -DCMAKE_C_COMPILER=/usr/bin/gcc-9 -DCMAKE_CXX_COMPILER=/usr/bin/g++-9 ..
cmake --build .
cp leelaz /leela/

echo "Installing Katago"
sudo apt-get install libcudnn7 libcudnn7-dev unzip libzip-dev -y
cd
rm -rf ./KataGo
git clone https://github.com/lightvector/KataGo.git

cd KataGo
mkdir build && cd build
cmake . -DBUILD_MCTS=1 -DUSE_BACKEND=CUDA -DCMAKE_CUDA_COMPILER=/usr/local/cuda-10.1/bin/nvcc -DCMAKE_C_COMPILER=/usr/bin/gcc-9 -DCMAKE_CXX_COMPILER=/usr/bin/g++-9 ../cpp
cmake --build .
cp katago /leela/

cd /leela
./download-best-network.sh
./download-elf-network.sh
./download-katago-network.sh
