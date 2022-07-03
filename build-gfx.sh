#!/usr/bin/env bash

export NAME=SDL2_gfx
export VERSION=1.0.4
export EXTRACT_COMMAND='unzip'
export EXTENSION=zip
export LIBDIR=.libs
export LIBNAME=libSDL2_gfx

source targets

declare -A BUILDERS
BUILDERS[linux_amd64]="common"
BUILDERS[linux_386]="common"
BUILDERS[linux_arm]="common"
BUILDERS[linux_arm_rpi]="common"
BUILDERS[linux_arm_vivante]="common"
BUILDERS[linux_mipsel]="common"
BUILDERS[android_arm]="cmake"
BUILDERS[android_arm64]="cmake"
BUILDERS[darwin_amd64]="common"
BUILDERS[windows_amd64]="common"
BUILDERS[windows_386]="common"

declare -A EXTRA_ARGS
EXTRA_ARGS[linux_amd64]=""
EXTRA_ARGS[linux_386]=""
EXTRA_ARGS[linux_arm]=""
EXTRA_ARGS[linux_arm_rpi]=""
EXTRA_ARGS[linux_arm_vivante]=""
EXTRA_ARGS[linux_mipsel]=""
EXTRA_ARGS[android_arm]=""
EXTRA_ARGS[android_arm64]=""
EXTRA_ARGS[darwin_amd64]=""
EXTRA_ARGS[windows_amd64]=""
EXTRA_ARGS[windows_386]=""

platforms=(
	linux_amd64
	linux_386
	linux_arm
	linux_arm_rpi
	linux_arm_vivante
	linux_mipsel
	android_arm
	android_arm64
	darwin_amd64
	windows_amd64
	windows_386
)

eprintln() {
	echo "$1" >&2
}

# Check if we have source code
if ! [ -d "${NAME}-${VERSION}" ]; then
	eprintln "${NAME} source doesn't exist"
	if ! [ -e "${NAME}-${VERSION}.${EXTENSION}" ]; then
		curl --fail -O -L "http://www.ferzkopp.net/Software/${NAME}/${NAME}-${VERSION}.${EXTENSION}"
		ret=$?
		if [ $ret != 0 ]; then
			eprintln "Could not download ${NAME}-${VERSION}.${EXTENSION}!"
			exit $ret
		fi
	fi

	${EXTRACT_COMMAND} "${NAME}-${VERSION}.${EXTENSION}"
fi

chmod +x ${NAME}-${VERSION}/configure

# Build SDL2_ttf for all platforms
for platform in ${platforms[@]}; do
	# Check if SDL2_ttf is already built for this platform
	if [ -e "${NAME}-${VERSION}/.go-sdl2-libs/lib${NAME}_${platform}.a" ]; then
		eprintln "${NAME} has already been built for ${platform}"
		continue
	fi
	export TARGET=${TARGETS[$platform]}
	eprintln "Building ${NAME} for $platform"
	eprintln "PLATFORM: ${platform}"
	eprintln "TARGET: ${TARGET}"
	./common-${platform}.sh ${EXTRA_ARGS[$platform]}
	cp "${NAME}-${VERSION}/.go-sdl2-libs/${LIBNAME}_${platform}.a" go-sdl2/.go-sdl2-libs/
done
