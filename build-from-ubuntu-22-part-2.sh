#!/bin/sh
sudo apt-get install -y libgoogle-perftools-dev libprotobuf-c-dev protobuf-c-compiler libboost-system-dev gcc g++ cmake git
wget -qO- "https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB" | sudo apt-key add -
sudo sh -c "echo deb https://apt.repos.intel.com/mkl all main > /etc/apt/sources.list.d/intel-mkl.list"
sudo apt-get update -o Dir::Etc::sourcelist="/etc/apt/sources.list.d/intel-mkl.list"
sudo apt-get install -y --no-install-recommends intel-mkl-64bit-2020.0-088
git clone https://github.com/marian-nmt/marian
cd marian/
mkdir build
cd build
CC=/usr/bin/gcc-11 CXX=/usr/bin/g++-11 CUDAHOSTCXX=/usr/bin/g++-11 cmake ..  \
  -DBoost_ARCHITECTURE=-x64 \
  -DCMAKE_BUILD_TYPE=Slim \
  -DCOMPILE_CPU=on \
  -DCOMPILE_CUDA=true \
  -DCOMPILE_KEPLER=true \
  -DCOMPILE_MAXWELL=true \
  -DCOMPILE_SERVER=on \
  -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-11 \
  -DUSE_FBGEMM=false \
  -DUSE_SENTENCEPIECE=on \
  -DUSE_STATIC_LIBS=on
make -j4
