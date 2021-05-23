FROM alpine:latest

ARG CMAKE_VERSION=3.19.8
ARG CMAKE_DOWNLOAD_ARTIFACT_TOKEN

# See: http://bugs.python.org/issue19846
ENV LANG=C.UTF-8
ENV TZ=Etc/UTC

RUN apk add --no-cache ca-certificates tzdata build-base

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
