FROM alpine:latest

ARG CMAKE_VERSION=3.19.8
ARG CMAKE_DOWNLOAD_ARTIFACT_TOKEN

# See: http://bugs.python.org/issue19846
ENV LANG=C.UTF-8
ENV TZ=Etc/UTC

# Note that some of those packages may not be needed; they are the packages
# installed by build-base minus the gcc and g++ packages.
RUN apk add --no-cache \
    file libgomp libgphobos gmp isl22 mpfr4 mpc1 \
    musl-dev libc-dev \
    llvm clang \
    ninja \
    ca-certificates tzdata

# Fix for CMake needing GCC on the first run even if it's detecting and using
# the Clang compiler... Explanation: CMake performs a quick test to see if the
# detected compiler is working. It detects Clang, but yet use some GCC-related
# configuration which will fail unless the GCC compilers are installed. To make
# sure the Clang compiler ends up being used, the CC and CXX variables are set.
RUN apk add --no-cache gcc g++
ENV CC=/usr/bin/clang
ENV CXX=/usr/bin/clang++

# This dependency on a different RUN command to highlight it and not forget it
# later
RUN apk add --no-cache linux-headers

ADD get-cmake.sh /
RUN set -eux; \
    apk add --no-cache curl unzip jq; \
    sh get-cmake.sh; \
    unzip cmake.zip; \
	tar -xvf cmake-$CMAKE_VERSION.tar.gz -C /usr/local/ --strip-components 1; \
    rm -r cmake-$CMAKE_VERSION.tar.gz cmake.zip get-cmake.sh; \
    apk del curl unzip jq

# Those are the run-time deps of CMake (or it will result in missing symbols)
RUN apk add --no-cache libuv libarchive rhash-libs libcurl
