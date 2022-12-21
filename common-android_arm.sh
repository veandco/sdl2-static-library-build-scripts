#!/usr/bin/env bash

ARCH=android_arm

cd ${DIRNAME}
rm -r build-${ARCH} 2> /dev/null
mkdir -p build-${ARCH} && cd build-${ARCH}

export NDK=/opt/android-ndk-r25b

export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64
export API=21
export AR=$TOOLCHAIN/bin/llvm-ar
export CC=$TOOLCHAIN/bin/$TARGET$API-clang
export AS=$CC
export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
export LD=$TOOLCHAIN/bin/ld
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip
export CFLAGS="-fPIE -fPIC"
export LDFLAGS="-pie -lOpenSLES"
#export CFLAGS="-g -O2 -march=armv7-a -mfpu=vfpv3-d16 -mfloat-abi=softfp -mthumb"
#export LDFLAGS="-march=armv7-a -Wl,--fix-cortex-a8 -lOpenSLES"
#export LDFLAGS="-L$TOOLCHAIN/sysroot/usr/lib/arm-linux-androideabi/$API -lhidapi -lOpenSLES"
../configure --prefix="$HOME/.${TARGET}" --host $TARGET $@
make -j$(nproc)
make install
cp ${LIBDIR}/${LIBNAME}.a ${LIBDIR}/${LIBNAME}.a.debug
${STRIP} --strip-unneeded ${LIBDIR}/${LIBNAME}.a
${RANLIB} ${LIBDIR}/${LIBNAME}.a
cp ${LIBDIR}/${LIBNAME}.a ../.go-sdl2-libs/${LIBNAME}_${ARCH}.a
