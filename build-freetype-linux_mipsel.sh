#!/usr/bin/env bash

export NAME=freetype
export TARGET="mipsel-linux-gnu"
export LIBDIR=.libs
export ARCH=linux_mipsel

./common-${ARCH}.sh --enable-freetype-config

cd ..
