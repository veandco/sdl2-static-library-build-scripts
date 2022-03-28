FROM ubuntu:latest as base

LABEL maintainer="veandco"

ENV DEBIAN_FRONTEND "noninteractive"

RUN dpkg --add-architecture i386; \
    apt-get update; \
    apt-get install -y make cmake git gcc g++ libxml2-dev libssl-dev zlib1g-dev zlib1g-dev:i386 \
        libgl-dev libgl-dev:i386  \
        gcc-mipsel-linux-gnu g++-mipsel-linux-gnu  \
        curl clang unzip wget gcc-arm-linux-gnueabi \
        gcc-i686-linux-gnu gcc-mingw-w64 libxext-dev

# Needed for compiler-rt in osxcross (https://github.com/tpoechtrager/osxcross/issues/214#issuecomment-595279668)
RUN ln -sf /usr/bin/llvm-config-10 /usr/bin/llvm-config

FROM base as downloads

ARG ANDROID_NDK_VERSION="r24"
ENV ANDROID_NDK_VERSION ${ANDROID_NDK_VERSION}

RUN wget -O /opt/android-ndk.zip https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux.zip; \
    unzip -q /opt/android-ndk.zip; \
    rm /opt/android-ndk.zip

RUN git clone https://github.com/tpoechtrager/osxcross; \
    wget -P osxcross/tarballs \
      https://go-sdl2.veandco.sg-sin1.upcloudobjects.com/MacOSX11.3.sdk.tar.xz \
      https://go-sdl2.veandco.sg-sin1.upcloudobjects.com/MacOSX10.11.sdk.tar.xz

FROM downloads as final

ENV ANDROID_NDK "/opt/android-ndk-${ANDROID_NDK_VERSION}"
ENV ANDROID_NDK_TARGET_ABI "30"


ENV PATH "${ANDROID_NDK}/toolchains/llvm/prebuilt/linux-x86_64/bin:${PATH}"
