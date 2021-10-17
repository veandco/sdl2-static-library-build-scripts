#!/usr/bin/env bash

# Install system dependencies
dpkg --add-architecture i386
apt update
apt install -y make cmake git gcc g++ libxml2-dev libssl-dev zlib1g-dev{,:i386} libgl-dev{,:i386} {gcc,g++}-mipsel-linux-gnu curl clang unzip gcc-arm-linux-gnueabi google-android-ndk-installer gcc-i686-linux-gnu gcc-mingw-w64 libxext-dev

# Needed for compiler-rt in osxcross (https://github.com/tpoechtrager/osxcross/issues/214#issuecomment-595279668)
ln -sf /usr/bin/llvm-config-10 /usr/bin/llvm-config

# macOS Only
git clone https://github.com/tpoechtrager/osxcross
cd osxcross/tarballs
curl -O https://go-sdl2.veandco.sg-sin1.upcloudobjects.com/MacOSX11.3.sdk.tar.xz
curl -O https://go-sdl2.veandco.sg-sin1.upcloudobjects.com/MacOSX10.11.sdk.tar.xz
cd ..
SDK_VERSION=11.3 ./build.sh
SDK_VERSION=10.11 ./build.sh
./build_compiler_rt.sh
cd ..
