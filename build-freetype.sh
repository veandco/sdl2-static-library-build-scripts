#!/usr/bin/env bash

export NAME=freetype
export VERSION=2.9.1

eprintln() {
	echo "$1" >&2
}

platforms=(
	linux_amd64
	linux_386
	linux_arm
	linux_arm_rpi
	linux_arm_vivante
	linux_mipsel
	android_arm
	darwin_amd64
	windows_amd64
	windows_386
)

# Check if we have source code
if ! [ -d "${NAME}-${VERSION}" ]; then
	eprintln "${NAME} source doesn't exist"
	if ! [ -e "${NAME}-${VERSION}.tar.gz" ]; then
		curl --fail -O -L "https://download.savannah.gnu.org/releases/freetype/${NAME}-${VERSION}.tar.gz"
		ret=$?
		if [ $ret != 0 ]; then
			eprintln "Could not download ${NAME}-${VERSION}.tar.gz!"
			exit $ret
		fi
	fi

	tar xf "${NAME}-${VERSION}".tar.gz
fi

# Build SDL2 for all platforms
for platform in ${platforms[@]}; do
	# Check if already built for this platform
	if [ -e "${NAME}-${VERSION}/.go-sdl2-libs/lib${NAME}_${platform}.a" ]; then
		eprintln "${NAME} has already been built for ${platform}"
		continue
	fi
	eprintln "Building ${NAME} for $platform"

	export ARCH=${platform}
	"./build-${NAME}-${platform}.sh"
done

cp ${NAME}-${VERSION}/.go-sdl2-libs/lib${NAME}*.a go-sdl2/.go-sdl2-libs/
