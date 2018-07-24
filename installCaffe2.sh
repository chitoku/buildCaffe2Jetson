#!/bin/bash

# Install Dependencies
sudo apt-get update
sudo apt-get install -y --no-install-recommends \
      build-essential \
      cmake \
      git \
      libgoogle-glog-dev \
      libgtest-dev \
      libiomp-dev \
      libleveldb-dev \
      liblmdb-dev \
      libopencv-dev \
      libopenmpi-dev \
      libsnappy-dev \
      libprotobuf-dev \
      openmpi-bin \
      openmpi-doc \
      protobuf-compiler \
      python-dev \
      python-pip                          
sudo -H pip install --user \
      future \
      numpy \
      protobuf

# Clone Caffe2's source code from our Github repository
git clone https://github.com/pytorch/pytorch.git && cd pytorch
git checkout -b v0.4.0_Jetson v0.4.0
git cherry-pick 14ad2e74f108d13ec98abb078f6aa7f01aae0aad
git submodule update --init --recursive

# Create a directory to put Caffe2's build files in
mkdir build && cd build

# Configure Caffe2's build
# This looks for packages on your machine and figures out which functionality
# to include in the Caffe2 installation. The output of this command is very
# useful in debugging.
cmake ..

# Compile, link, and install Caffe2
sudo make install

# Test the Caffe2 Instllation
cd ~ && python -c 'from caffe2.python import core' 2>/dev/null && echo "Success" || echo "Failure"

