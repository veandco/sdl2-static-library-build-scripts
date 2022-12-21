#!/usr/bin/env bash

cd ${DIRNAME}
rm -r build-${ARCH} 2> /dev/null
mkdir -p .go-sdl2-libs

export CC="${TARGET}-gcc"
export CXX="${TARGET}-g++"

export PATH="$HOME/.${TARGET}/bin:${PATH}"
mkdir -p build-${ARCH} && cd build-${ARCH}
cmake .. -DCMAKE_INSTALL_PREFIX:PATH="$HOME/.${TARGET}"
make -j$(nproc)
make install
cp ${LIBDIR}/${LIBNAME}.a ${LIBDIR}/${LIBNAME}.a.debug
${TARGET}-strip --strip-unneeded ${LIBDIR}/${LIBNAME}.a
#${TARGET}-ranlib ${LIBDIR}/${LIBNAME}.a
cp ${LIBDIR}/${LIBNAME}.a ../.go-sdl2-libs/${LIBNAME}_${ARCH}.a
