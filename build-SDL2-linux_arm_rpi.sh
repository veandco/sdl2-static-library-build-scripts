#!/usr/bin/env bash

TARGET="arm-linux-gnu"
LIBDIR=build/.libs



cd SDL2-${SDL2_VERSION}
mkdir -p .go-sdl2-libs/include/SDL2
rm -r build-linux-arm-rpi 2> /dev/null

export CC="arm-linux-gnueabi-gcc"
export CXX="arm-linux-gnueabi-g++"

mkdir -p build-linux-arm-rpi && cd build-linux-arm-rpi
../configure --prefix="$HOME/.${TARGET}-rpi" --host="${TARGET}" --disable-video-wayland --disable-video-vivante --enable-video-rpi --disable-video-x11 --enable-video-opengl --disable-video-kmsdrm --disable-pulseaudio --enable-video-opengles
make -j$(nproc)
make install
cp ${LIBDIR}/libSDL2.a ${LIBDIR}/libSDL2.a.debug
arm-linux-gnueabi-strip ${LIBDIR}/libSDL2.a
arm-linux-gnueabi-ranlib ${LIBDIR}/libSDL2.a
cp ${LIBDIR}/libSDL2.a ../.go-sdl2-libs/libSDL2_linux_arm_rpi.a
cp include/SDL_config.h ../.go-sdl2-libs/include/SDL2/SDL_config_linux_arm_rpi.h

cd ..
