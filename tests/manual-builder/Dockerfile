FROM alpine:3.20

ENV GIT_COMMIT="a186a9ae823d91678ace87ef5b920688c555f5b5"

RUN set -xe \
    && apk add --no-cache --virtual .fetch-deps \
    git \
    && git clone --recurse-submodules https://github.com/tdlib/telegram-bot-api.git src \
    && ( cd src && git checkout $GIT_COMMIT ) \
    && apk add --no-cache --virtual .build-deps \
    cmake \
    make \
    clang \
    musl-dev \
    zlib-dev \
    openssl-dev \
    gperf \
    linux-headers \
    && ( cd src \
    && mkdir build \
    && cd build \
    && CC=clang cmake -DCMAKE_BUILD_TYPE=Release .. )
