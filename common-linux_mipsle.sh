#!/usr/bin/env bash

ARCH=linux_mipsle

cd ${DIRNAME}
rm -r build-${ARCH} 2> /dev/null
mkdir -p .go-sdl2-libs

export CC="mipsel-linux-gnu-gcc"
export CXX="mipsel-linux-gnu-g++"
export PATH="$HOME/.${TARGET}/bin:${PATH}"
mkdir -p build-${ARCH} && cd build-${ARCH}
if [ $NAME = 'zlib' ]; then
	../configure --prefix="$HOME/.${TARGET}" $@
else
	if [ $NAME = 'libpng' ]; then
		ZLIBLIB=/root/.${TARGET}/lib export ZLIBLIB
		ZLIBINC=/root/.${TARGET}/include export ZLIBINC
		CPPFLAGS="-I$ZLIBINC" export CPPFLAGS
		LDFLAGS="-L$ZLIBLIB" export LDFLAGS
		LD_LIBRARY_PATH="$ZLIBLIB:$LD_LIBRARY_PATH" export LD_LIBRARY_PATH
	fi
	../configure --host="${TARGET}" --prefix="$HOME/.${TARGET}" $@
fi
make -j$(nproc)
make install
cp ${LIBDIR}/${LIBNAME}.a ${LIBDIR}/${LIBNAME}.a.debug
${TARGET}-strip --strip-unneeded ${LIBDIR}/${LIBNAME}.a
#${TARGET}-ranlib ${LIBDIR}/${LIBNAME}.a
cp ${LIBDIR}/${LIBNAME}.a ../.go-sdl2-libs/${LIBNAME}_${ARCH}.a

cd ..
