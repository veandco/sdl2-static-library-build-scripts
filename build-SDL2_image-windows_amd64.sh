#!/usr/bin/env bash

TARGET="x86_64-w64-mingw32"
LIBDIR=.libs
NAME=SDL2_image


cd ${NAME}-${VERSION}
mkdir -p .go-sdl2-libs/include/SDL2

rm -r build-windows-amd64 2> /dev/null

export PATH="$HOME/.${TARGET}/bin:$PATH"
mkdir -p build-windows-amd64 && cd build-windows-amd64
../configure --host=${TARGET} --prefix="$HOME/.${TARGET}"
make -j$(nproc)
make install
cp ${LIBDIR}/lib${NAME}.a ${LIBDIR}/lib${NAME}.a.debug
strip ${LIBDIR}/lib${NAME}.a
ranlib ${LIBDIR}/lib${NAME}.a
cp ${LIBDIR}/lib${NAME}.a ../.go-sdl2-libs/lib${NAME}_windows_amd64.a

cd ..
