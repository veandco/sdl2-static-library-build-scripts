#!/usr/bin/env bash

source versions
source targets

export NAME=freetype
export VERSION=${FT_VERSION}
export EXTRACT_COMMAND='tar xf'
export EXTENSION=tar.gz
export LIBDIR=.libs
export LIBNAME=libfreetype
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
EXTRA_ARGS[linux_amd64]="--enable-freetype-config"
EXTRA_ARGS[linux_386]="--enable-freetype-config"
EXTRA_ARGS[linux_arm]="--enable-freetype-config"
EXTRA_ARGS[linux_arm_rpi]="--enable-freetype-config"
EXTRA_ARGS[linux_arm_vivante]="--enable-freetype-config"
EXTRA_ARGS[linux_mipsel]="--enable-freetype-config"
EXTRA_ARGS[android_arm]="--enable-freetype-config"
EXTRA_ARGS[darwin_amd64]="--enable-freetype-config"
EXTRA_ARGS[darwin_arm64]="--enable-freetype-config --with-bzip2=no --with-zlib=no"
EXTRA_ARGS[windows_amd64]="--enable-freetype-config"
EXTRA_ARGS[windows_386]="--enable-freetype-config"

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
		curl --fail -O -L "https://download.savannah.gnu.org/releases/freetype/${NAME}-${VERSION}.${EXTENSION}"
		ret=$?
		if [ $ret != 0 ]; then
			eprintln "Could not download ${NAME}-${VERSION}.${EXTENSION}!"
			exit $ret
		fi
	fi

	${EXTRACT_COMMAND} "${NAME}-${VERSION}.${EXTENSION}"
fi

# Build SDL2 for all platforms
for platform in ${platforms[@]}; do
	# Check if already built for this platform
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
