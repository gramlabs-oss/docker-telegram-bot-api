#!/usr/bin/env sh

# 如果 `LOCAL_API` 为 true，则设置 OPTS 为 "--local"
if [ "$LOCAL_API" = "true" ]; then
    OPTS="--local"
fi

ARGS="--api-id $TELEGRAM_API_ID --api-hash $TELEGRAM_API_HASH $OPTS"

echo telegram-bot-api $ARGS

telegram-bot-api $ARGS
