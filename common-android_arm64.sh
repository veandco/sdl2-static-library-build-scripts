#!/usr/bin/env bash

ARCH=android_arm64

cd ${NAME}-${VERSION}
rm -r build-${ARCH} 2> /dev/null

export CC="aarch64-linux-android32-clang"
export CXX="aarch64-linux-android32-clang++"
mkdir -p build-${ARCH} && cd build-${ARCH}
../configure --prefix="$HOME/.${TARGET}" $@
#../configure --prefix="$HOME/.${TARGET}" --with-libs="${ANDROID_NDK}/platforms/android-16/arch-arm/usr/lib" --with-headers="${ANDROID_NDK}/platforms/android-14/arch-arm/usr/include" $@
make -j$(nproc)
make install
cp ${LIBDIR}/${LIBNAME}.a ${LIBDIR}/${LIBNAME}.a.debug
#${TARGET}-strip ${LIBDIR}/${LIBNAME}.a
#${TARGET}-ranlib ${LIBDIR}/${LIBNAME}.a
cp ${LIBDIR}/${LIBNAME}.a ../.go-sdl2-libs/${LIBNAME}_${ARCH}.a
