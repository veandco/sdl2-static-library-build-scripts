#!/usr/bin/env bash

cd ${NAME}-${VERSION}
rm -r build-${ARCH} 2> /dev/null

export CC="arm-linux-gnueabi-gcc"
export CXX="arm-linux-gnueabi-g++"

export PATH="$HOME/.${TARGET}-rpi/bin:${PATH}"
mkdir -p build-${ARCH} && cd build-${ARCH}
../configure --host=${TARGET} --prefix="$HOME/.${TARGET}-rpi" $@
make -j$(nproc)
make install
cp ${LIBDIR}/lib${NAME}.a ${LIBDIR}/lib${NAME}.a.debug
arm-linux-gnueabi-strip ${LIBDIR}/lib${NAME}.a
arm-linux-gnueabi-ranlib ${LIBDIR}/lib${NAME}.a
mkdir -p ../.go-sdl2-libs
cp ${LIBDIR}/lib${NAME}.a ../.go-sdl2-libs/lib${NAME}_${ARCH}.a
