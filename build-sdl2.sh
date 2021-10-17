#!/usr/bin/env bash

export NAME=SDL2
export VERSION=2.0.16

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

# Check if we have SDL2 source code
if ! [ -d "${NAME}-${VERSION}" ]; then
	eprintln "SDL2 source doesn't exist"
	if ! [ -e "${NAME}-${VERSION}.zip" ]; then
		curl --fail -O -L "https://libsdl.org/release/${NAME}-${VERSION}.zip"
		ret=$?
		if [ $ret != 0 ]; then
			eprintln "Could not download ${NAME}-${VERSION}.zip!"
			exit $ret
		fi
	fi

	unzip "${NAME}-${VERSION}"
fi

# Build SDL2 for all platforms
for platform in ${platforms[@]}; do
	# Check if SDL2 is already built for this platform
	if [ -e "${NAME}-${VERSION}/.go-sdl2-libs/libSDL2_${platform}.a" ] && [ -e "${NAME}-${VERSION}/.go-sdl2-libs/include/SDL2/SDL_config_${platform}.h" ]; then
		eprintln "SDL2 has already been built for ${platform}"
		continue
	fi
	eprintln "Building SDL2 for $platform"

	export ARCH=${platform}
	"./build-${NAME}-${platform}.sh"
done

cp ${NAME}-${VERSION}/.go-sdl2-libs/lib${NAME}*.a go-sdl2/.go-sdl2-libs/
cp ${NAME}-${VERSION}/.go-sdl2-libs/include/SDL2/*.h go-sdl2/.go-sdl2-libs/include/SDL2/
