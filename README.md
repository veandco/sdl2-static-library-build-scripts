# Go-SDL2 Static Library Build Scripts

This contains scripts used to build static libraries used by go-sdl2. Currently, this process assumes modern Fedora systems but we would love to make it work other distros such as Ubuntu as well!

## Download SDL2 source code

```
curl -O https://libsdl.org/release/SDL2-2.0.16.zip
```

## Install build tools

### linux amd64

```
sudo dnf install -y glibc-devel libstdc++-devel
```

### linux 386

```
sudo dnf install -y glibc-devel.i686 libstdc++-devel.i686
```

### windows amd64

```
sudo dnf install -y mingw64-gcc
```

### windows 386

```
sudo dnf install -y mingw32-gcc
```

### darwin

NOTE: Use SDK version 10.x for amd64 and 11.x for arm64

#### Method 1: Using pre-built macOS SDK packages

1. Clone osxcross

```
git clone https://github.com/tpoechtrager/osxcross
```

2. Download pre-built macOS SDKs

```
cd osxcross/tarballs
curl -O https://go-sdl2.veandco.sg-sin1.upcloudobjects.com/MacOSX11.1.sdk.tar.bz2
curl -O https://go-sdl2.veandco.sg-sin1.upcloudobjects.com/MacOSX10.10.sdk.tar.bz2
cd ..
```

3. Build the osxcross tools

```
./build.sh
```

4. (SDK version 10.x only) Add a couple lines in `osxcross/target/SDK/MacOSX[version].sdk/usr/include/TargetConditionals.sh`

```
...
# gcc based compiler used on Mac OS X
#if defined(__GNUC__) && ( defined(__APPLE_CPP__) || defined(__APPLE_CC__) || defined(__MACOS_CLASSIC__) )
        #define TARGET_OS_MAC               1
    #define TARGET_OS_WIN32             0
    #define TARGET_OS_UNIX              0
    #define TARGET_OS_EMBEDDED          0 
    #define TARGET_OS_IPHONE            0 
    #define TARGET_OS_TV                0 // Add this line
    #define TARGET_OS_IOS               0 // Add this line
...
```

#### Method 2: Build the SDKs on macOS

On macOS

1. Install Xcode

You can install Xcode from the app store or from https://developer.apple.com/download/more

2. Clone osxcross on a darwin arm64 system

```
git clone https://github.com/tpoechtrager/osxcross
```

3. Generate SDK package

```
cd osxcross
./tools/gen_sdk_package.sh
```

4. Put the generated SDK tarballs into `osxcross/tarballs` and follow method 1 from step 3.

## Build static libraries

To build the static libraries, execute one of the `build-*.sh` scripts
