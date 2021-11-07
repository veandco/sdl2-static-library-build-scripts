#!/usr/bin/env bash

export TARGET="arm-linux-androideabi"
export LIBDIR=.libs

export PATH="$HOME/.${TARGET}/bin:$PATH"
./common-${ARCH}.sh

cd ..
