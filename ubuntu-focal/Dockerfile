FROM ubuntu:focal

ARG CMAKE_VERSION=3.19.8

# See: http://bugs.python.org/issue19846
ENV LANG=C.UTF-8
ENV TZ=Etc/UTC

ARG DEBIAN_FRONTEND=noninteractive
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates netbase tzdata \
		clang ninja-build \
	; \
	update-alternatives --set cc /usr/bin/clang ; \
	update-alternatives --set c++ /usr/bin/clang++; \
	rm -rf /var/lib/apt/lists/*

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends wget; \
	wget https://github.com/Kitware/CMake/releases/download/v$CMAKE_VERSION/cmake-$CMAKE_VERSION-Linux-x86_64.tar.gz; \
	tar -xvf cmake-$CMAKE_VERSION-Linux-x86_64.tar.gz -C /usr/local/ --strip-components 1; \
	rm cmake-$CMAKE_VERSION-Linux-x86_64.tar.gz; \
	apt-get remove -y wget; \
	rm -rf /var/lib/apt/lists/*
