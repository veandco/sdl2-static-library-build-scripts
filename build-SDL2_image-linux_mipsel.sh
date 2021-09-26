#!/usr/bin/env bash

NAME=SDL2_image
TARGET="mipsel-linux-gnu"
LIBDIR=.libs


cd ${NAME}-${VERSION}
mkdir -p .go-sdl2-libs/include/SDL2
rm -r build-linux-mipsel 2> /dev/null

export PATH="$HOME/.${TARGET}/bin:${PATH}"
mkdir -p build-linux-mipsel && cd build-linux-mipsel
../configure --prefix="$HOME/.${TARGET}" --host="${TARGET}"
make -j$(nproc)
make install
cp ${LIBDIR}/lib${NAME}.a ${LIBDIR}/lib${NAME}.a.debug
${TARGET}-strip ${LIBDIR}/lib${NAME}.a
${TARGET}-ranlib ${LIBDIR}/lib${NAME}.a
cp ${LIBDIR}/lib${NAME}.a ../.go-sdl2-libs/lib${NAME}_linux_mipsel.a

cd ..
