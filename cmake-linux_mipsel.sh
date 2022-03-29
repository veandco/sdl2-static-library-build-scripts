#!/usr/bin/env bash

cd ${NAME}-${VERSION}
rm -r build-${ARCH} 2> /dev/null

export CC="${TARGET}-gcc"
export CXX="${TARGET}-g++"

export PATH="$HOME/.${TARGET}/bin:${PATH}"
mkdir -p build-${ARCH} && cd build-${ARCH}
cmake .. -DCMAKE_INSTALL_PREFIX:PATH="$HOME/.${TARGET}"
make -j$(nproc)
make install
cp lib${LIBRARY_NAME}.a lib${LIBRARY_NAME}.a.debug
${TARGET}-strip lib${LIBRARY_NAME}.a
${TARGET}-ranlib lib${LIBRARY_NAME}.a
mkdir -p ../.go-sdl2-libs
cp lib${LIBRARY_NAME}.a ../.go-sdl2-libs/lib${LIBRARY_NAME}_${ARCH}.a
