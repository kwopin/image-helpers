FROM alpine:latest

ARG CMAKE_VERSION=3.19.8

# See: http://bugs.python.org/issue19846
ENV LANG=C.UTF-8
ENV TZ=Etc/UTC

RUN apk add --no-cache ca-certificates tzdata build-base

ADD get-cmake.sh /
RUN set -eux; \
    apk add --no-cache curl unzip jq; \
    sh get-cmake.sh; \
    unzip cmake.zip; \
	tar -xvf cmake-$CMAKE_VERSION.tar.gz -C /usr/local/ --strip-components 1; \
    rm -r cmake-$CMAKE_VERSION.tar.gz cmake.zip get-cmake.sh; \
    apk del curl unzip jq
