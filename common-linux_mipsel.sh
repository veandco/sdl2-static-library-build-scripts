#!/usr/bin/env bash

cd ${NAME}-${VERSION}
rm -r build-${ARCH} 2> /dev/null

export PATH="$HOME/.${TARGET}/bin:${PATH}"
mkdir -p build-${ARCH} && cd build-${ARCH}
../configure --host=${TARGET} --prefix="$HOME/.${TARGET}" $@
make -j$(nproc)
make install
cp ${LIBDIR}/lib${NAME}.a ${LIBDIR}/lib${NAME}.a.debug
${TARGET}-strip ${LIBDIR}/lib${NAME}.a
${TARGET}-ranlib ${LIBDIR}/lib${NAME}.a
mkdir -p ../.go-sdl2-libs
cp ${LIBDIR}/lib${NAME}.a ../.go-sdl2-libs/lib${NAME}_${ARCH}.a