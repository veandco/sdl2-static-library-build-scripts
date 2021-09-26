#!/usr/bin/env bash

NAME=SDL2_image
TARGET="arm-linux-androideabi"
LIBDIR=.libs


cd ${NAME}-${VERSION}
mkdir -p .go-sdl2-libs/include/SDL2
rm -r build-android-arm 2> /dev/null

ANDROID_NDK="/usr/lib/android-ndk"
ANDROID_STANDALONE_TOOLCHAIN="$ANDROID_NDK/toolchains/arm-linux-androideabi-4.9"
export PATH="$ANDROID_STANDALONE_TOOLCHAIN/prebuilt/linux-x86_64/bin:$PATH"
mkdir -p build-android_arm && cd build-android_arm
../configure --prefix="$HOME/.${TARGET}"
make -j$(nproc)
make install
cp ${LIBDIR}/lib${NAME}.a ${LIBDIR}/lib${NAME}.a.debug
${TARGET}-strip ${LIBDIR}/lib${NAME}.a
${TARGET}-ranlib ${LIBDIR}/lib${NAME}.a
cp ${LIBDIR}/lib${NAME}.a ../.go-sdl2-libs/lib${NAME}_android_arm.a

cd ..