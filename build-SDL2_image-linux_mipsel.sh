#!/usr/bin/env bash

export TARGET="mipsel-linux-gnu"
export LIBDIR=.libs

./common-${ARCH}.sh --host=${TARGET}

cd ..