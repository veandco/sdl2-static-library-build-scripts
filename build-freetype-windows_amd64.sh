#!/usr/bin/env bash

export NAME=freetype
export TARGET="x86_64-w64-mingw32"
export LIBDIR=.libs
export ARCH=windows_amd64

./common-${ARCH}.sh --enable-freetype-config

cd ..
