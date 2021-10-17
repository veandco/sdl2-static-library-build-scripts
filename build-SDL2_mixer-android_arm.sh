#!/usr/bin/env bash

export TARGET="arm-linux-androideabi"
export LIBDIR=build/.libs

./common-${ARCH}.sh

cd ..
