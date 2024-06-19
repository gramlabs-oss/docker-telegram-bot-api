# docker-telegram-bot-api

[![status-badge](https://multiarch-ci.hentioe.dev/api/badges/8/status.svg)](https://multiarch-ci.hentioe.dev/repos/8)

Docker image of [telegram-bot-api](https://github.com/tdlib/telegram-bot-api), supports arm64/amd64.

## Usage

`docker-compose.yml` example:

```yaml
services:
  telegram-bot-api:
    image: gramoss/telegram-bot-api:7.5
    environment:
      TELEGRAM_API_ID: <YOUR_TELEGRAM_API_ID>
      TELEGRAM_API_HASH: <YOUR_TELEGRAM_API_HASH>
      TELEGRAM_LOCAL_MODE: true # Add `--local` option

  your-bot:
    # Your bot service
    # Use `http://telegram-bot-api` as base url
```

The default port is `80`, through the built-in Nginx reverse proxy, it also supports accessing `<locale_base_url>/file/bot<token>/<file_path>` to download files!
