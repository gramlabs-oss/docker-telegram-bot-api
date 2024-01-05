# docker-telegram-bot-api

Docker image of [telegram-bot-api](https://github.com/tdlib/telegram-bot-api), supports arm64/amd64.

## Usage

`docker-compose.yml` example:

```yaml
services:
  telegram-bot-api:
    image: gramoss/telegram-bot-api:ade0841 # Tag hash corresponds to commit
    environment:
      TELEGRAM_API_ID: <YOUR_TELEGRAM_API_ID>
      TELEGRAM_API_HASH: <YOUR_TELEGRAM_API_HASH>
      TELEGRAM_LOCAL_MODE: true # Add `--local` option

  your-bot:
    # Your bot service
    # Use `http://telegram-bot-api:8081` as base url
```

The default port is `8081`。
