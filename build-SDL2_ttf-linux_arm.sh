#!/usr/bin/env bash

export TARGET="arm-linux-gnu"
export LIBDIR=.libs

./common-${ARCH}.sh --host=${TARGET}

cd ..
