#!/usr/bin/env bash

export TARGET="arm-linux-gnu"
export LIBDIR=build/.libs

./common-${ARCH}.sh --host=${TARGET} --disable-video-wayland --enable-video-vivante --disable-video-rpi --disable-video-x11 --enable-video-opengl --disable-video-kmsdrm --disable-pulseaudio --enable-video-opengles
cd ${NAME}-${VERSION}
mkdir -p .go-sdl2-libs/include/SDL2/
cp include/SDL_config.h .go-sdl2-libs/include/SDL2/SDL_config_${ARCH}.h

cd ..
