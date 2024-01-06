FROM alpine:3.18

ENV GIT_COMMIT="ade0841d41b7126c2d908475291a5e1cd8a1b905"

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

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
    binutils \
    && ( cd src \
    && mkdir build \
    && cd build \
    && CC=clang cmake -DCMAKE_BUILD_TYPE=Release .. \
    && cmake --build . --target install -j $(nproc) ) \
    # strip 新安装的 telegram-bot-api 二进制文件
    && scanelf --nobanner -E ET_EXEC -BF '%F' --recursive /usr/local | xargs -r strip --strip-all \
    && scanelf --nobanner -E ET_DYN -BF '%F' --recursive /usr/local | xargs -r strip --strip-unneeded \
    && apk add --virtual .telegram-bot-api-rundeps \
    libstdc++ \
    && rm -rf src \
    && apk del .fetch-deps .build-deps

EXPOSE 8081

ENTRYPOINT [ "entrypoint.sh" ]