FROM alpine:3.20

ENV GIT_COMMIT="ecfce9042b61bc3719f51014aff238b5ac14a5ad"

WORKDIR /data

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
    && apk add --no-cache --virtual .telegram-bot-api-rundeps \
    libstdc++ \
    nginx \
    && rm -rf src \
    && apk del .fetch-deps .build-deps

COPY bot-api.conf /etc/nginx/http.d/default.conf

RUN set -xe \
    # 修改 Nginx 用户
    && sed -i 's/user nginx;/user root;/g' /etc/nginx/nginx.conf

EXPOSE 8081

ENTRYPOINT [ "entrypoint.sh" ]