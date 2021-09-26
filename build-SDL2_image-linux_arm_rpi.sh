#!/usr/bin/env bash

NAME=SDL2_image
TARGET="arm-linux-gnu"
LIBDIR=.libs


cd ${NAME}-${VERSION}
mkdir -p .go-sdl2-libs/include/SDL2
rm -r build-linux-arm-rpi 2> /dev/null

export CC="arm-linux-gnueabi-gcc"
export CXX="arm-linux-gnueabi-g++"
export PATH="$HOME/.${TARGET}-rpi/bin:${PATH}"
mkdir -p build-linux-arm-rpi && cd build-linux-arm-rpi
../configure --prefix="$HOME/.${TARGET}-rpi" --host="${TARGET}"
make -j$(nproc)
make install
cp ${LIBDIR}/lib${NAME}.a ${LIBDIR}/lib${NAME}.a.debug
arm-linux-gnueabi-strip ${LIBDIR}/lib${NAME}.a
arm-linux-gnueabi-ranlib ${LIBDIR}/lib${NAME}.a
cp ${LIBDIR}/lib${NAME}.a ../.go-sdl2-libs/lib${NAME}_linux_arm_rpi.a

cd ..
