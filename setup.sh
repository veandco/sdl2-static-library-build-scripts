#!/usr/bin/env bash

# Install system dependencies
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install -y automake make cmake git gcc g++ libxml2-dev libssl-dev zlib1g-dev{,:i386} libgl-dev{,:i386} {gcc,g++}-mipsel-linux-gnu curl clang unzip {gcc,g++}-arm-linux-gnueabi {gcc,g++}-i686-linux-gnu {gcc,g++}-mingw-w64 libxext-dev software-properties-common

# Android
#sudo apt install -y google-android-ndk-installer

# Needed for compiler-rt in osxcross (https://github.com/tpoechtrager/osxcross/issues/214#issuecomment-595279668)
sudo ln -sf /usr/bin/llvm-config-10 /usr/bin/llvm-config

# macOS Only
git clone --depth 1 https://github.com/tpoechtrager/osxcross
cd osxcross/tarballs
curl -O https://s3.veand.co/go-sdl2/MacOSX11.3.sdk.tar.xz
curl -O https://s3.veand.co/go-sdl2/MacOSX10.14.sdk.tar.xz
cd ..
echo | SDK_VERSION=11.3 ./build.sh
echo | SDK_VERSION=10.14 ./build.sh
./build_compiler_rt.sh
cd ..
