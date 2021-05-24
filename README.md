# Kwopin - Docker Image Helpers

This repository provides the Docker images that are used by the development
pipeline.

Some are to speed up the build and/or reduce the length of the workflow files.
The others are to provide tricky environment to get right such as the Android
emulators to run the unit tests.

**Notes**

- Current shipped version of CMake is 3.19.8
- Version of command-line tools package used in Android SDK is 4.0
- Version of NDK bundle package used in Android SDK is 22.1.7171670
- For now version of Alpine is set to latest but it should be set to a specific version
- Android emulator images are missing
- To build the Alpine image locally, you need to use the `--build-arg CMAKE_DOWNLOAD_ARTIFACT_TOKEN=<token>` flag with a valid token (required by `get-cmake.sh`)

## The Alpine and Ubuntu images

Those two are the standard images with the 'build packages' installed (which
are almost always needed by every job of the pipeline). It also comes with the
specific CMake version 3.19.8 installed. Additionally, it installs the Python
runtimes (set up of the locale and timezone and installation of the CA
certificates).

Technically, they could be split into separate images because the needs for
each job are not always the same...

- unit tests jobs don't need CMake and the build packages
- external packages that don't build any extension module only need the make tool

... and it might hide information. But for now, keeping it simple will do.

## The Android NDK image

This image provides the environment needed to build our version of Python for
Android on Ubuntu. The Android NDK folder has all the tools needed to
cross-compile for the different architectures, therefore there is only a single
image.

The ANDROID_SDK_ROOT (and ANDROID_NDK_ROOT) environment variable is defined and
points to `/root/android-sdk`.

The way the Android SDK is bootstrap is unusual but it is the right way to do
it. The `cmdline-tools` package contains the `sdkmanager` tool which is needed
to populate the Android SDK. It creates an egg or chicken situation which is
avoided by downloading the `cmdline-tools` package manually from the official
website (the exact version of this package is not mentioned), which is used to
re-download the `cmdline-tools` package with a clear and specific version. It
also lets the `sdkmanager` populate the Android SDK from **scratch**, avoiding
us to make mistake or assuming a given file structure which might no longer be
the same later.
