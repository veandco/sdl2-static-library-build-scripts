#!/usr/bin/env bash

ARCH=android_arm

cd ${NAME}-${VERSION}
rm -r build-${ARCH} 2> /dev/null

ANDROID_NDK="/usr/lib/android-ndk"
ANDROID_STANDALONE_TOOLCHAIN="$ANDROID_NDK/toolchains/arm-linux-androideabi-4.9"
TOOLCHAIN_PREFIX=arm-linux-android-eabi
export PATH="$ANDROID_STANDALONE_TOOLCHAIN/prebuilt/linux-x86_64/bin:$PATH"
export CC="${TARGET}-gcc"
export CXX="${TARGET}-g++"
mkdir -p build-${ARCH} && cd build-${ARCH}
../configure --prefix="$HOME/.${TARGET}" $@
#../configure --prefix="$HOME/.${TARGET}" --with-libs="${ANDROID_NDK}/platforms/android-16/arch-arm/usr/lib" --with-headers="${ANDROID_NDK}/platforms/android-14/arch-arm/usr/include" $@
make -j$(nproc)
make install
cp ${LIBDIR}/${LIBNAME}.a ${LIBDIR}/${LIBNAME}.a.debug
#${TARGET}-strip ${LIBDIR}/${LIBNAME}.a
#${TARGET}-ranlib ${LIBDIR}/${LIBNAME}.a
cp ${LIBDIR}/${LIBNAME}.a ../.go-sdl2-libs/${LIBNAME}_${ARCH}.a
