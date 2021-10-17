#!/usr/bin/env bash

export TARGET="arm-linux-gnu"
export LIBDIR=.libs

export PATH="$HOME/.${TARGET}/bin:$PATH"
./common-${ARCH}.sh --host=${TARGET}

cd ..
