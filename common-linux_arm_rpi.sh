#!/usr/bin/env bash

ARCH=linux_arm_rpi

cd ${DIRNAME}
rm -r build-${ARCH} 2> /dev/null

export CC="arm-linux-gnueabi-gcc"
export CXX="arm-linux-gnueabi-g++"
export PATH="$HOME/.${TARGET}-rpi/bin:${PATH}"
mkdir -p build-${ARCH} && cd build-${ARCH}
../configure --host="${TARGET}" --prefix="$HOME/.${TARGET}-rpi" $@
make -j$(nproc)
make install
cp ${LIBDIR}/${LIBNAME}.a ${LIBDIR}/${LIBNAME}.a.debug
arm-linux-gnueabi-strip --strip-unneeded ${LIBDIR}/${LIBNAME}.a
#arm-linux-gnueabi-ranlib ${LIBDIR}/${LIBNAME}.a
mkdir -p ../.go-sdl2-libs
cp ${LIBDIR}/${LIBNAME}.a ../.go-sdl2-libs/${LIBNAME}_${ARCH}.a

cd ..
