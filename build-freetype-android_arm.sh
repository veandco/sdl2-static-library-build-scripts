#!/usr/bin/env bash

export NAME=freetype
export TARGET="arm-linux-androideabi"
export LIBDIR=.libs
export ARCH=android_arm

./common-${ARCH}.sh --enable-freetype-config

cd ..
