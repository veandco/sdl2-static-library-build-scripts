#!/usr/bin/env bash

NAME=SDL2_image
TARGET="x86_64-linux-gnu"
LIBDIR=.libs

cd ${NAME}-${VERSION}
mkdir -p .go-sdl2-libs/include/SDL2
rm -r build-linux-amd64 2> /dev/null

export PATH="$HOME/.${TARGET}/bin:$PATH"
mkdir -p build-linux-amd64 && cd build-linux-amd64
../configure --prefix="$HOME/.${TARGET}"
make -j$(nproc)
make install
cp ${LIBDIR}/lib${NAME}.a ${LIBDIR}/lib${NAME}.a.debug
strip ${LIBDIR}/lib${NAME}.a
ranlib ${LIBDIR}/lib${NAME}.a
cp ${LIBDIR}/lib${NAME}.a ../.go-sdl2-libs/lib${NAME}_linux_amd64.a

cd ..
