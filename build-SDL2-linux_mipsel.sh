#!/usr/bin/env bash

TARGET="mipsel-linux-gnu"
LIBDIR=build/.libs



cd SDL2-${SDL2_VERSION}
mkdir -p .go-sdl2-libs/include/SDL2
rm -r build-linux-mipsel 2> /dev/null



mkdir -p build-linux-mipsel && cd build-linux-mipsel
../configure --disable-video-wayland --disable-video-vivante --disable-video-rpi --enable-video-x11 --enable-video-opengl --disable-video-kmsdrm --disable-pulseaudio --enable-video-opengles --prefix="$HOME/.${TARGET}" --host="${TARGET}"
make -j$(nproc)
make install
cp ${LIBDIR}/libSDL2.a ${LIBDIR}/libSDL2.a.debug
${TARGET}-strip ${LIBDIR}/libSDL2.a
${TARGET}-ranlib ${LIBDIR}/libSDL2.a
cp ${LIBDIR}/libSDL2.a ../.go-sdl2-libs/libSDL2_linux_mipsel.a
cp include/SDL_config.h ../.go-sdl2-libs/include/SDL2/SDL_config_linux_mipsel.h

cd ..
