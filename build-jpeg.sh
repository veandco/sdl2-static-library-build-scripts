#!/usr/bin/env bash

source platforms
source versions
source targets

export NAME=libjpeg
export VERSION=${JPG_VERSION}
export EXTRACT_COMMAND='tar xf'
export EXTENSION=tar.gz
export LIBDIR=.
export LIBNAME=libjpeg
export DIRNAME=libjpeg-turbo-${JPG_VERSION}
export TARGET_LIBNAME=libjpeg

declare -A BUILDERS
BUILDERS[linux_amd64]="cmake"
BUILDERS[linux_386]="cmake"
BUILDERS[linux_arm]="cmake"
BUILDERS[linux_arm_rpi]="cmake"
BUILDERS[linux_arm_vivante]="cmake"
BUILDERS[linux_mipsle]="cmake"
BUILDERS[android_arm]="cmake"
BUILDERS[darwin_amd64]="cmake"
BUILDERS[darwin_arm64]="cmake"
BUILDERS[windows_amd64]="cmake"
BUILDERS[windows_386]="cmake"

declare -A EXTRA_ARGS
EXTRA_ARGS[linux_amd64]=""
EXTRA_ARGS[linux_386]=""
EXTRA_ARGS[linux_arm]=""
EXTRA_ARGS[linux_arm_rpi]=""
EXTRA_ARGS[linux_arm_vivante]=""
EXTRA_ARGS[linux_mipsle]=""
EXTRA_ARGS[android_arm]=""
EXTRA_ARGS[darwin_amd64]=""
EXTRA_ARGS[darwin_arm64]=""
EXTRA_ARGS[windows_amd64]=""
EXTRA_ARGS[windows_386]=""

eprintln() {
	echo "$1" >&2
}

# Check if we have source code
if ! [ -d "${DIRNAME}" ]; then
	eprintln "${NAME} source doesn't exist"
	if ! [ -e "libjpeg-turbo-${VERSION}.tar.gz" ]; then
		curl --fail -O -L "https://download.sourceforge.net/libjpeg-turbo/libjpeg-turbo-${VERSION}.tar.gz"
		ret=$?
		if [ $ret != 0 ]; then
			eprintln "Could not download libjpeg-turbo-${VERSION}.tar.gz!"
			exit $ret
		fi
	fi

	${EXTRACT_COMMAND} "libjpeg-turbo-${VERSION}.tar.gz"
fi

# Build SDL2 for all platforms
for platform in ${platforms[@]}; do
	# Check if SDL2 is already built for this platform
	if [ -e "${DIRNAME}/.go-sdl2-libs/lib${NAME}_${platform}.a" ]; then
		eprintln "${NAME} has already been built for ${platform}"
		continue
	fi
	export ARCH=$platform
	export TARGET=${TARGETS[$platform]}
	eprintln "Building ${NAME} for $platform"
	eprintln "PLATFORM: ${platform}"
	eprintln "TARGET: ${TARGET}"
	./${BUILDERS[$platform]}-${platform}.sh ${EXTRA_ARGS[$platform]}
done
