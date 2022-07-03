#!/usr/bin/env bash

export NAME=freetype
export TARGET="arm-linux-androideabi"
export LIBDIR=.libs
export ARCH=android_arm64

./common-${ARCH}.sh --enable-freetype-config

cd ..
