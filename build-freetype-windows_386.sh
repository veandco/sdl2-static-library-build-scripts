#!/usr/bin/env bash

export NAME=freetype
export TARGET="i686-w64-mingw32"
export LIBDIR=.libs
export ARCH=windows_386

./common-${ARCH}.sh --enable-freetype-config

cd ..
