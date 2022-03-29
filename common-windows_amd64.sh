#!/usr/bin/env bash

ARCH=windows_amd64

cd ${NAME}-${VERSION}
rm -r build-${ARCH} 2> /dev/null

export PATH="$HOME/.${TARGET}/bin:$PATH"
export CC="${TARGET}-gcc"
export CXX="${TARGET}-g++"
export RC="${TARGET}-windres"
mkdir -p build-${ARCH} && cd build-${ARCH}
../configure --host="${TARGET}" --prefix="$HOME/.${TARGET}" $@
make -j$(nproc)
make install
cp ${LIBDIR}/lib${NAME}.a ${LIBDIR}/lib${NAME}.a.debug
#strip ${LIBDIR}/lib${NAME}.a
#ranlib ${LIBDIR}/lib${NAME}.a
cp ${LIBDIR}/lib${NAME}.a ../.go-sdl2-libs/lib${NAME}_${ARCH}.a

cd ..
