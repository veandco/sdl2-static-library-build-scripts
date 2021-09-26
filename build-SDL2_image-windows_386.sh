#!/usr/bin/env bash

TARGET="i686-w64-mingw32"
LIBDIR=.libs
NAME=SDL2_image


cd ${NAME}-${VERSION}
mkdir -p .go-sdl2-libs/include/SDL2

rm -r build-windows-386 2> /dev/null

export PATH="$HOME/.${TARGET}/bin:$PATH"
mkdir -p build-windows-386 && cd build-windows-386
../configure --host=${TARGET} --prefix="$HOME/.${TARGET}"
make -j$(nproc)
make install
cp ${LIBDIR}/lib${NAME}.a ${LIBDIR}/lib${NAME}.a.debug
strip ${LIBDIR}/lib${NAME}.a
ranlib ${LIBDIR}/lib${NAME}.a
cp ${LIBDIR}/lib${NAME}.a ../.go-sdl2-libs/lib${NAME}_windows_386.a

cd ..
