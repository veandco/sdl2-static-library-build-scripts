#!/usr/bin/env bash

NAME=SDL2_image
TARGET="i686-linux-gnu"
LIBDIR=.libs

cd ${NAME}-${VERSION}
mkdir -p .go-sdl2-libs/include/SDL2
rm -r build-linux-386 2> /dev/null

export PATH="$HOME/.${TARGET}/bin:$PATH"
mkdir -p build-linux-386 && cd build-linux-386
../configure --host=${TARGET} --prefix="$HOME/.${TARGET}"
make -j$(nproc)
make install
cp ${LIBDIR}/lib${NAME}.a ${LIBDIR}/lib${NAME}.a.debug
strip ${LIBDIR}/lib${NAME}.a
ranlib ${LIBDIR}/lib${NAME}.a
cp ${LIBDIR}/lib${NAME}.a ../.go-sdl2-libs/lib${NAME}_linux_386.a

cd ..
