#!/usr/bin/env sh

# 如果 `TELEGRAM_LOCAL_MODE` 为 true，则设置 OPTS 为 "--local"
if [ "$TELEGRAM_LOCAL_MODE" = "true" ]; then
    OPTS="--local"
fi

ARGS="--api-id $TELEGRAM_API_ID --api-hash $TELEGRAM_API_HASH $OPTS"

echo telegram-bot-api $ARGS

telegram-bot-api $ARGS
