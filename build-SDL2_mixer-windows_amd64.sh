#!/usr/bin/env bash

export TARGET="x86_64-w64-mingw32"
export LIBDIR=build/.libs

./common-${ARCH}.sh --host=${TARGET}

cd ..
