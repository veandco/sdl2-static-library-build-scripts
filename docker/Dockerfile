FROM ubuntu:latest as base

LABEL maintainer="veandco"

ENV DEBIAN_FRONTEND "noninteractive"

RUN dpkg --add-architecture i386; \
    apt-get update; \
    apt-get install -y make cmake git gcc g++ libxml2-dev libssl-dev zlib1g-dev zlib1g-dev:i386 \
        libgl-dev libgl-dev:i386  \
        gcc-mipsel-linux-gnu g++-mipsel-linux-gnu  \
        curl clang unzip wget gcc-arm-linux-gnueabi \
        gcc-i686-linux-gnu gcc-mingw-w64 libxext-dev \
        xz-utils

# Needed for compiler-rt in osxcross (https://github.com/tpoechtrager/osxcross/issues/214#issuecomment-595279668)
RUN ln -sf /usr/bin/llvm-config-10 /usr/bin/llvm-config

FROM base as android_ndk

ARG ANDROID_NDK_VERSION="r24"
ENV ANDROID_NDK_VERSION ${ANDROID_NDK_VERSION}

RUN wget -O /opt/android-ndk.zip https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux.zip; \
    unzip -q /opt/android-ndk.zip -d /opt; \
    rm /opt/android-ndk.zip

FROM android_ndk as macos

WORKDIR /opt

RUN git clone https://github.com/tpoechtrager/osxcross; \
    wget -P osxcross/tarballs https://s3.veand.co/go-sdl2/MacOSX10.14.sdk.tar.xz; \
    wget -P osxcross/tarballs https://s3.veand.co/go-sdl2/MacOSX11.3.sdk.tar.xz

WORKDIR /opt/osxcross

RUN UNATTENDED=1 SDK_VERSION=11.3 ./build.sh
RUN UNATTENDED=1 SDK_VERSION=10.14 ./build.sh
RUN ./build_compiler_rt.sh

FROM macos as final

ENV ANDROID_NDK "/opt/android-ndk-${ANDROID_NDK_VERSION}"
ENV ANDROID_NDK_TARGET_ABI "30"

ENV PATH "${ANDROID_NDK}/toolchains/llvm/prebuilt/linux-x86_64/bin:${PATH}"
ENV PATH "/opt/osxcross/target/bin:${PATH}"

CMD /bin/bash