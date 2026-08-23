# CloudCLI installer

Публичный установщик [CloudCLI](https://cloudcli.ai) на Ubuntu VPS: веб-панель + Claude Code и/или ChatGPT Codex за HTTPS на своём домене.

Панель ставится из npm-пакета `@cloudcli-ai/cloudcli` ([siteboon/claudecodeui](https://github.com/siteboon/claudecodeui), AGPL-3.0-or-later). Этот репозиторий содержит **только установщик**, не форк панели.

Лицензия установщика: [AGPL-3.0-or-later](LICENSE).

## Dry-run (без установок)

На любой машине, без root:

```bash
DRY_RUN=1 AGENT=claude DOMAIN=ai.example.test EMAIL=dev@example.test bash install.sh
```

Или:

```bash
bash tests/dry-run.sh
```

## Установка на VPS

Ubuntu 22.04/24.04, root, 4 ГБ RAM, A-запись домена на IP сервера:

```bash
AGENT=claude DOMAIN=ai.example.com EMAIL=you@example.com bash install.sh
```

Интерактивно: `bash install.sh`.

## Что ставится

- Node.js 22, Caddy, UFW, Fail2Ban
- `@anthropic-ai/claude-code` и/или `@openai/codex`
- systemd-служба `claude-panel` (порт 3001), проекты в `/workspace`

Нужна подписка Claude Pro и/или ChatGPT Plus. Один аккаунт — один сервер.
