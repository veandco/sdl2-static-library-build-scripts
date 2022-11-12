#!/usr/bin/env bash

source versions
source targets

export NAME=mpg123
export VERSION=${MPG123_VERSION}
export EXTRACT_COMMAND='tar xf'
export EXTENSION=tar.bz2
export LIBDIR=src/libmpg123/.libs
export LIBNAME=libmpg123
export DIRNAME=mpg123-${VERSION}
export TARGET_LIBNAME=libmpg123

declare -A BUILDERS
BUILDERS[linux_amd64]="common"
BUILDERS[linux_386]="common"
BUILDERS[linux_arm]="common"
BUILDERS[linux_arm_rpi]="common"
BUILDERS[linux_arm_vivante]="common"
BUILDERS[linux_mipsel]="common"
BUILDERS[android_arm]="common"
BUILDERS[darwin_amd64]="common"
BUILDERS[darwin_arm64]="common"
BUILDERS[windows_amd64]="common"
BUILDERS[windows_386]="common"

declare -A EXTRA_ARGS
EXTRA_ARGS[linux_amd64]="--enable-static"
EXTRA_ARGS[linux_386]="--enable-static"
EXTRA_ARGS[linux_arm]="--enable-static"
EXTRA_ARGS[linux_arm_rpi]="--enable-static"
EXTRA_ARGS[linux_arm_vivante]="--enable-static"
EXTRA_ARGS[linux_mipsel]="--enable-static"
EXTRA_ARGS[android_arm]="--enable-static"
EXTRA_ARGS[darwin_amd64]="--enable-static"
EXTRA_ARGS[darwin_arm64]="--enable-static"
EXTRA_ARGS[windows_amd64]="--enable-static"
EXTRA_ARGS[windows_386]="--enable-static"

platforms=(
	linux_amd64
	linux_386
	linux_arm
	linux_arm_rpi
	linux_arm_vivante
	linux_mipsel
	android_arm
	darwin_amd64
	darwin_arm64
	windows_amd64
	windows_386
)

eprintln() {
	echo "$1" >&2
}

# Check if we have source code
if ! [ -d "${DIRNAME}" ]; then
	eprintln "${NAME} source doesn't exist"
	if ! [ -e "${NAME}-${VERSION}.${EXTENSION}" ]; then
		curl --fail -O -L "https://download.sourceforge.net/mpg123/${NAME}-${VERSION}.${EXTENSION}"
		ret=$?
		if [ $ret != 0 ]; then
			eprintln "Could not download mpg123-${VERSION}.${EXTENSION}!"
			exit $ret
		fi
	fi

	${EXTRACT_COMMAND} "${NAME}-${VERSION}.${EXTENSION}"
fi

# Build SDL2 for all platforms
for platform in ${platforms[@]}; do
	# Check if SDL2 is already built for this platform
	if [ -e "${DIRNAME}/.go-sdl2-libs/lib${NAME}_${platform}.a" ]; then
		eprintln "${NAME} has already been built for ${platform}"
		continue
	fi
	export TARGET=${TARGETS[$platform]}
	eprintln "Building ${NAME} for $platform"
	eprintln "PLATFORM: ${platform}"
	eprintln "TARGET: ${TARGET}"
	./${BUILDERS[$platform]}-${platform}.sh ${EXTRA_ARGS[$platform]}
done
