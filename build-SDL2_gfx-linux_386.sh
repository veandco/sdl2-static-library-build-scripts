#!/usr/bin/env bash

export TARGET="i686-linux-gnu"
export LIBDIR=.libs

export PATH="$HOME/.${TARGET}/bin:$PATH"
./common-${ARCH}.sh --host=${TARGET}

cd ..
