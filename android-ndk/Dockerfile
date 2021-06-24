FROM ubuntu:latest

ARG CMAKE_VERSION=3.19.8
ARG ANDROID_CMDLINE_TOOLS_VERSION=4.0
ARG ANDROID_NDK_VERSION=22.1.7171670

ENV ANDROID_SDK_ROOT=/root/android-sdk
ENV ANDROID_NDK_ROOT=/root/android-sdk/ndk/$ANDROID_NDK_VERSION

WORKDIR /root

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
        wget \
        unzip \
        openjdk-11-jdk \
        ninja-build \
	; \
	rm -rf /var/lib/apt/lists/*

# Install the specific version of CMake
RUN set -eux; \
	wget https://github.com/Kitware/CMake/releases/download/v$CMAKE_VERSION/cmake-$CMAKE_VERSION-Linux-x86_64.tar.gz; \
	tar -xvf cmake-$CMAKE_VERSION-Linux-x86_64.tar.gz -C /usr/local/ --strip-components 1; \
	rm cmake-$CMAKE_VERSION-Linux-x86_64.tar.gz

# Bootstrap the Android SDK folder with the command-line tools package
# installed.
RUN set -eux; \
    cd /root; \
    wget https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip; \
    unzip commandlinetools-linux-7302050_latest.zip; \
    mkdir dir; \
    echo y | cmdline-tools/bin/sdkmanager --sdk_root=android-sdk --install "cmdline-tools;4.0"; \
    rm -r cmdline-tools commandlinetools-linux-7302050_latest.zip

# Download the NDK bundle package.
RUN cd android-sdk && cmdline-tools/4.0/bin/sdkmanager --install "ndk;${ANDROID_NDK_VERSION}"
