#!/usr/bin/env bash

ARCH=android_arm64

cd ${NAME}-${VERSION}
rm -r build-${ARCH} 2> /dev/null

export CC="aarch64-linux-android32-clang"
export CXX="aarch64-linux-android32-clang++"

mkdir -p build-${ARCH} && cd build-${ARCH}
cmake .. -DCMAKE_INSTALL_PREFIX:PATH="$HOME/.${TARGET}" $@
#cmake .. -DCMAKE_INSTALL_PREFIX:PATH="$HOME/.${TARGET}" -DCMAKE_FIND_ROOT_PATH="/usr/lib/android-ndk/platforms/android-9/arch-arm" -DCMAKE_SYSROOT="/usr/lib/android-ndk/platforms/android-9/arch-arm" -DCMAKE_INCLUDE_PATH="/usr/lib/android-ndk/platforms/android-9/arch-arm/usr/include" -DCMAKE_LIBRARY_PATH="/usr/lib/android-ndk/platforms/android-9/arch-arm/usr/lib" $@
make -j$(nproc)
make install
cp lib${LIBRARY_NAME}.a lib${LIBRARY_NAME}.a.debug
#${TARGET}-strip lib${LIBRARY_NAME}.a
#${TARGET}-ranlib lib${LIBRARY_NAME}.a
cp lib${LIBRARY_NAME}.a ../.go-sdl2-libs/lib${LIBRARY_NAME}_${ARCH}.a
