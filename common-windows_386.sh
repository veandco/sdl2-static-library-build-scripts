#!/usr/bin/env bash

ARCH=windows_386

cd ${DIRNAME}
rm -r build-${ARCH} 2> /dev/null

export PATH="$HOME/.${TARGET}/bin:$PATH"
export CC="${TARGET}-gcc"
export CXX="${TARGET}-g++"
export RC="${TARGET}-windres"
mkdir -p build-${ARCH} && cd build-${ARCH}
../configure --host="${TARGET}" --prefix="$HOME/.${TARGET}" $@
make -j$(nproc)
make install
cp ${LIBDIR}/${LIBNAME}.a ${LIBDIR}/${LIBNAME}.a.debug
${TARGET}-strip --strip-unneeded ${LIBDIR}/${LIBNAME}.a
#ranlib ${LIBDIR}/${LIBNAME}.a
cp ${LIBDIR}/${LIBNAME}.a ../.go-sdl2-libs/${LIBNAME}_${ARCH}.a

cd ..
