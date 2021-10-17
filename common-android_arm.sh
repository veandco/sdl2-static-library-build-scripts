#!/usr/bin/env bash

cd ${NAME}-${VERSION}
rm -r build-${ARCH} 2> /dev/null

ANDROID_NDK="/usr/lib/android-ndk"
ANDROID_STANDALONE_TOOLCHAIN="$ANDROID_NDK/toolchains/arm-linux-androideabi-4.9"
export PATH="$ANDROID_STANDALONE_TOOLCHAIN/prebuilt/linux-x86_64/bin:$PATH"
mkdir -p build-${ARCH} && cd build-${ARCH}
../configure --prefix="$HOME/.${TARGET}" $@
make -j$(nproc)
make install
cp ${LIBDIR}/lib${NAME}.a ${LIBDIR}/lib${NAME}.a.debug
${TARGET}-strip ${LIBDIR}/lib${NAME}.a
${TARGET}-ranlib ${LIBDIR}/lib${NAME}.a
mkdir -p ../.go-sdl2-libs
cp ${LIBDIR}/lib${NAME}.a ../.go-sdl2-libs/lib${NAME}_${ARCH}.a
