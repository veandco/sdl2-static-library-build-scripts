#!/usr/bin/env bash

source versions
source targets

export NAME=SDL2_image
export VERSION=${IMG_VERSION}
export EXTRACT_COMMAND='unzip'
export EXTENSION=zip
export LIBDIR=.libs
export LIBNAME=libSDL2_image
export DIRNAME=${NAME}-${VERSION}

declare -A BUILDERS
BUILDERS[linux_amd64]="common"
BUILDERS[linux_386]="common"
BUILDERS[linux_arm]="common"
BUILDERS[linux_arm_rpi]="common"
BUILDERS[linux_arm_vivante]="common"
BUILDERS[linux_mipsel]="common"
BUILDERS[android_arm]="cmake"
BUILDERS[darwin_amd64]="common"
BUILDERS[darwin_arm64]="common"
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
EXTRA_ARGS[darwin_amd64]=""
EXTRA_ARGS[darwin_arm64]=""
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
		curl --fail -O -L "https://libsdl.org/projects/SDL_image/release/${NAME}-${VERSION}.${EXTENSION}"
		ret=$?
		if [ $ret != 0 ]; then
			eprintln "Could not download ${NAME}-${VERSION}.${EXTENSION}!"
			exit $ret
		fi
	fi

	${EXTRACT_COMMAND} "${NAME}-${VERSION}.${EXTENSION}"
fi

# Build SDL2_image for all platforms
for platform in ${platforms[@]}; do
	# Check if SDL2_image is already built for this platform
	if [ -e "${NAME}-${VERSION}/.go-sdl2-libs/lib${NAME}_${platform}.a" ]; then
		eprintln "${NAME} has already been built for ${platform}"
		continue
	fi
	export TARGET=${TARGETS[$platform]}
	eprintln "Building ${NAME} for $platform"
	eprintln "PLATFORM: ${platform}"
	eprintln "TARGET: ${TARGET}"
	./common-${platform}.sh ${EXTRA_ARGS[$platform]}
done
