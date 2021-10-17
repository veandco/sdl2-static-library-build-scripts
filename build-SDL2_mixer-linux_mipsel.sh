#!/usr/bin/env bash

export TARGET="mipsel-linux-gnu"
export LIBDIR=build/.libs

./common-${ARCH}.sh --host=${TARGET}

cd ..
