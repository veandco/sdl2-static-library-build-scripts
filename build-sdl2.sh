#!/usr/bin/env bash

source platforms
source versions
source targets

export NAME=SDL2
export VERSION=${SDL2_VERSION}
export EXTRACT_COMMAND='unzip'
export EXTENSION=zip
export LIBDIR=build/.libs
export LIBNAME=libSDL2
export DIRNAME=${NAME}-${VERSION}

declare -A BUILDERS
BUILDERS[linux_amd64]="common"
BUILDERS[linux_386]="common"
BUILDERS[linux_arm]="common"
BUILDERS[linux_arm_rpi]="common"
BUILDERS[linux_arm_vivante]="common"
BUILDERS[linux_mipsle]="common"
BUILDERS[android_arm]="common"
BUILDERS[android_arm64]="common"
BUILDERS[darwin_amd64]="common"
BUILDERS[darwin_arm64]="common"
BUILDERS[windows_amd64]="common"
BUILDERS[windows_386]="common"
BUILDERS[freebsd_amd64]="cmake"

declare -A EXTRA_ARGS
EXTRA_ARGS[linux_amd64]="--disable-pulseaudio"
EXTRA_ARGS[linux_386]="--disable-pulseaudio"
EXTRA_ARGS[linux_arm]="--disable-video-wayland --disable-video-vivante --disable-video-rpi --enable-video-x11 --enable-video-opengl --disable-video-kmsdrm --disable-pulseaudio --enable-video-opengles"
EXTRA_ARGS[linux_arm_rpi]="--disable-video-wayland --disable-video-vivante --enable-video-rpi --disable-video-x11 --enable-video-opengl --disable-video-kmsdrm --disable-pulseaudio --enable-video-opengles"
EXTRA_ARGS[linux_arm_vivante]="--disable-video-wayland --enable-video-vivante --disable-video-rpi --disable-video-x11 --enable-video-opengl --disable-video-kmsdrm --disable-pulseaudio --enable-video-opengles"
EXTRA_ARGS[linux_mipsle]="--disable-video-wayland --disable-video-vivante --disable-video-rpi --enable-video-x11 --enable-video-opengl --disable-video-kmsdrm --disable-pulseaudio --enable-video-opengles"
EXTRA_ARGS[android_arm]="--disable-hidapi"
EXTRA_ARGS[android_arm64]="--disable-hidapi"
EXTRA_ARGS[darwin_amd64]=""
EXTRA_ARGS[darwin_arm64]=""
EXTRA_ARGS[windows_amd64]=""
EXTRA_ARGS[windows_386]=""
EXTRA_ARGS[freebsd_amd64]=""

eprintln() {
	echo "$1" >&2
}

# Check if we have source code
if ! [ -d "${DIRNAME}" ]; then
	eprintln "${NAME} source doesn't exist"
	if ! [ -e "${NAME}-${VERSION}.${EXTENSION}" ]; then
		curl --fail -O -L "https://libsdl.org/release/${NAME}-${VERSION}.${EXTENSION}"
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
	# Check if SDL2 is already built for this platform
	if [ -e "${NAME}-${VERSION}/.go-sdl2-libs/lib${NAME}_${platform}.a" ]; then
		eprintln "${NAME} has already been built for ${platform}"
		continue
	fi
	export TARGET=${TARGETS[$platform]}
	eprintln "Building ${NAME} for $platform"
	eprintln "PLATFORM: ${platform}"
	eprintln "TARGET: ${TARGET}"
	./${BUILDERS[$platform]}-${platform}.sh ${EXTRA_ARGS[$platform]}
done
