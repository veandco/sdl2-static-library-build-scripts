#!/usr/bin/env bash

export TARGET="x86_64-apple-darwin15"
export LIBDIR=build/.libs
export OSXCROSS="$PWD/osxcross"

./common-${ARCH}.sh --host=${TARGET}

cd ..