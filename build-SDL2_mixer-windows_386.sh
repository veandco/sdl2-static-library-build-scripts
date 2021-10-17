#!/usr/bin/env bash

export TARGET="i686-w64-mingw32"
export LIBDIR=build/.libs

./common-${ARCH}.sh --host=${TARGET}

cd ..
