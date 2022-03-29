#!/usr/bin/env bash

ARCH=android_arm

cd ${NAME}-${VERSION}
rm -r build-${ARCH} 2> /dev/null

export CC="${TARGET}-gcc"
export CXX="${TARGET}-g++"

export ANDROID_NDK="/usr/lib/android-ndk"
export ANDROID_STANDALONE_TOOLCHAIN="$ANDROID_NDK/toolchains/arm-linux-androideabi-4.9"
export PATH="$ANDROID_STANDALONE_TOOLCHAIN/prebuilt/linux-x86_64/bin:$PATH"
mkdir -p build-${ARCH} && cd build-${ARCH}
cmake .. -DCMAKE_INSTALL_PREFIX:PATH="$HOME/.${TARGET}" -DCMAKE_SYSROOT="/usr/lib/android-ndk/platforms/android-24/arch-arm" $@
#cmake .. -DCMAKE_INSTALL_PREFIX:PATH="$HOME/.${TARGET}" -DCMAKE_FIND_ROOT_PATH="/usr/lib/android-ndk/platforms/android-9/arch-arm" -DCMAKE_SYSROOT="/usr/lib/android-ndk/platforms/android-9/arch-arm" -DCMAKE_INCLUDE_PATH="/usr/lib/android-ndk/platforms/android-9/arch-arm/usr/include" -DCMAKE_LIBRARY_PATH="/usr/lib/android-ndk/platforms/android-9/arch-arm/usr/lib" $@
make -j$(nproc)
make install
cp lib${LIBRARY_NAME}.a lib${LIBRARY_NAME}.a.debug
#${TARGET}-strip lib${LIBRARY_NAME}.a
#${TARGET}-ranlib lib${LIBRARY_NAME}.a
cp lib${LIBRARY_NAME}.a ../.go-sdl2-libs/lib${LIBRARY_NAME}_${ARCH}.a
