#!/usr/bin/env bash

export TARGET="x86_64-apple-darwin15"
export LIBDIR=.libs
export OSXCROSS="$PWD/osxcross"

./common-${ARCH}.sh --enable-freetype-config

cd ..
