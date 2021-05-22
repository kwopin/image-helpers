# Kwopin - Docker Image Helpers

This repository provides the Docker images that are used by the development
pipeline.

Some are to speed up the build and/or reduce the length of the workflow files.
The others are to provide tricky environment to get right such as the Android
emulators to run the unit tests.

**Notes**

- Current shipped version of CMake is 3.19.8
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
