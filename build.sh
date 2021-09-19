export SDL2_VERSION=2.0.16

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
	darwin_arm64
	windows_amd64
	windows_386
)

# Check if we have SDL2 source code
if ! [ -d "SDL2-${SDL2_VERSION}" ]; then
	eprintln "SDL2 source doesn't exist"
	if ! [ -e "SDL2-${SDL2_VERSION}.zip" ]; then
		curl --fail -O -L "https://libsdl.org/release/SDL2-${SDL2_VERSION}.zip"
		ret=$?
		if [ $ret != 0 ]; then
			eprintln "Could not download SDL2-${SDL2_VERSION}.zip!"
			exit $ret
		fi
	fi

	unzip "SDL2-${SDL2_VERSION}"
fi

# Build SDL2 for all platforms
for platform in ${platforms[@]}; do
	# Check if SDL2 is already built for this platform
	if [ -e "SDL2-${SDL2_VERSION}/.go-sdl2-libs/libSDL2_${platform}.a" ] && [ -e "SDL2-${SDL2_VERSION}/.go-sdl2-libs/include/SDL2/SDL_config_${platform}.h" ]; then
		eprintln "SDL2 has already been built for ${platform}"
		continue
	fi
	eprintln "Building SDL2 for $platform"
	"./build-SDL2-${platform}.sh"
done

cp SDL2-${SDL2_VERSION}/.go-sdl2-libs/libSDL2*.a go-sdl2/.go-sdl2-libs/
cp SDL2-${SDL2_VERSION}/.go-sdl2-libs/include/SDL2/*.h go-sdl2/.go-sdl2-libs/include/SDL2/
