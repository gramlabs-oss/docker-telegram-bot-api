#!/usr/bin/env sh

# 如果 `TELEGRAM_LOCAL_MODE` 为 true，则设置 OPTS 为 "--local"
if [ "$TELEGRAM_LOCAL_MODE" = "true" ]; then
    OPTS="--local"
fi

ARGS="--api-id $TELEGRAM_API_ID --api-hash $TELEGRAM_API_HASH -p 8081 -s 8082 $OPTS"

# 如果外部传入了参数，则将参数追加到 `ARGS` 变量后面
if [ $# -gt 0 ]; then
    ARGS="$ARGS $@"
fi

COMMAND="telegram-bot-api $ARGS"

echo $COMMAND

nginx

echo "nginx: /bot->8081;/stat->8082"

exec $COMMAND
