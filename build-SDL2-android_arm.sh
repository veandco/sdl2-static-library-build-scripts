#!/usr/bin/env bash

TARGET="arm-linux-androideabi"
LIBDIR=build/.libs

cd SDL2-${SDL2_VERSION}
mkdir -p .go-sdl2-libs/include/SDL2
rm -r build-android-arm 2> /dev/null

ANDROID_NDK="/usr/lib/android-ndk"
ANDROID_STANDALONE_TOOLCHAIN="$ANDROID_SDK/toolchains/arm-linux-androideabi-4.9"
export PATH="$ANDROID_STANDALONE_TOOLCHAIN/prebuilt/linux-x86_64/bin:$PATH"
mkdir -p build-android_arm && cd build-android_arm
../configure --prefix="$HOME/.${TARGET}"
make -j$(nproc)
make install
cp ${LIBDIR}/libSDL2.a ${LIBDIR}/libSDL2.a.debug
arm-linux-androideabi-strip ${LIBDIR}/libSDL2.a
arm-linux-androideabi-ranlib ${LIBDIR}/libSDL2.a
cp ${LIBDIR}/libSDL2.a ../.go-sdl2-libs/libSDL2_android_arm.a
cp include/SDL_config.h ../.go-sdl2-libs/include/SDL2/SDL_config_android_arm.h

cd ..

#export ANDROID_NDK=/opt/android-ndk
#export ANDROID_STANDALONE_TOOLCHAIN=/opt/android-toolchain-arm7
#export PATH=/opt/android-toolchain-arm7/bin:${PATH}
#mkdir -p build-android-arm && cd build-android-arm
#cmake -DCMAKE_TOOLCHAIN_FILE=../Toolchain-android.cmake -DHIDAPI=OFF -DVIDEO_OPENGL=OFF ..
#make -j$(nproc)
##cp libSDL2.a libSDL2.a.debug
##arm-linux-androideabi-strip libSDL2.a
##arm-linux-androideabi-ranlib libSDL2.a
#cp libSDL2.a ../.go-sdl2-libs/libSDL2_android_arm.a
#cp include/SDL_config.h ../.go-sdl2-libs/include/SDL2/SDL_config_android_arm.h
