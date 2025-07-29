#!/usr/bin/env sh

if [ "$TELEGRAM_LOCAL_MODE" = "true" ]; then
    # If `TELEGRAM_LOCAL_MODE` is true, set OPTS to "--local"
    OPTS="--local"
fi

ARGS="--api-id $TELEGRAM_API_ID --api-hash $TELEGRAM_API_HASH -p 8081 -s 8082 $OPTS"

# If additional arguments are passed, append them to the `ARGS` variable
if [ $# -gt 0 ]; then
    ARGS="$ARGS $@"
fi

COMMAND="telegram-bot-api $ARGS"

echo $COMMAND

nginx

echo "nginx: /bot->8081;/stat->8082"

exec $COMMAND
