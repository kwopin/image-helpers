FROM ubuntu:latest

ARG AVD_NAME=kwopin
ARG ANDROID_CMDLINE_TOOLS_VERSION=4.0
ENV ANDROID_SDK_ROOT=/root/android-sdk

WORKDIR /root

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
        wget \
        unzip \
        openjdk-11-jdk \
	; \
	rm -rf /var/lib/apt/lists/*

# Bootstrap the Android SDK folder with the command-line tools package
# installed.
RUN set -eux; \
    cd /root; \
    wget https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip; \
    unzip commandlinetools-linux-7302050_latest.zip; \
    mkdir dir; \
    echo y | cmdline-tools/bin/sdkmanager --sdk_root=android-sdk --install "cmdline-tools;4.0"; \
    rm -r cmdline-tools commandlinetools-linux-7302050_latest.zip

# Download emulator and the images.
RUN $ANDROID_SDK_ROOT/cmdline-tools/4.0/bin/sdkmanager --install "patcher;v4"
RUN $ANDROID_SDK_ROOT/cmdline-tools/4.0/bin/sdkmanager --install "platforms;android-30"
RUN $ANDROID_SDK_ROOT/cmdline-tools/4.0/bin/sdkmanager --install "system-images;android-30;google_apis;x86_64"
RUN $ANDROID_SDK_ROOT/cmdline-tools/4.0/bin/sdkmanager --install "emulator"
RUN $ANDROID_SDK_ROOT/cmdline-tools/4.0/bin/sdkmanager --install "platform-tools"

# Create the emulator.
RUN echo no | $ANDROID_SDK_ROOT/cmdline-tools/4.0/bin/avdmanager create avd \
  --name $AVD_NAME \
  --tag google_apis \
  --abi x86_64 \
  --package "system-images;android-30;google_apis;x86_64"

EXPOSE 5554
EXPOSE 5555
EXPOSE 5037

USER root
CMD $ANDROID_SDK_ROOT/platform-tools/adb start-server && $ANDROID_SDK_ROOT/emulator/emulator -avd kwopin -no-window -no-audio
