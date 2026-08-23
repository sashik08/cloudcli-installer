# CloudCLI installer

Установщик [CloudCLI](https://cloudcli.ai) на свой Ubuntu VPS: веб-панель с Claude Code и/или ChatGPT Codex по вашему домену (HTTPS).

Этот репозиторий — **только скрипт установки**. Панель ставится из npm-пакета [`@cloudcli-ai/cloudcli`](https://www.npmjs.com/package/@cloudcli-ai/cloudcli) ([siteboon/claudecodeui](https://github.com/siteboon/claudecodeui), AGPL-3.0-or-later).

Лицензия установщика: [AGPL-3.0-or-later](LICENSE).

Пошаговая инструкция (VPS, DNS, вход в Claude, первый проект): [INSTALL.md](INSTALL.md).

## Установка

На сервере, от **root** (Ubuntu 22.04 или 24.04):

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/sashik08/cloudcli-installer/main/install.sh)"
```

Скрипт спросит агента (Claude или Codex), домен и email для Let’s Encrypt.

Неинтерактивно:

```bash
AGENT=claude DOMAIN=ai.example.com EMAIL=you@example.com \
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/sashik08/cloudcli-installer/main/install.sh)"
```

`AGENT`: `claude` или `codex`. Второй агент ставится повторным запуском той же команды.

Перед запуском на VPS:

1. A-запись домена указывает на IP сервера.
2. Открыты входящие порты 22, 80, 443.
3. Есть подписка Claude Pro и/или ChatGPT Plus. Один аккаунт — один сервер.

Рекомендуется **4 ГБ RAM**.

## Проверка без установок

На любой машине, без root и без пакетов:

```bash
DRY_RUN=1 AGENT=claude DOMAIN=ai.example.test EMAIL=dev@example.test \
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/sashik08/cloudcli-installer/main/install.sh)"
```

Локально из клона:

```bash
bash tests/dry-run.sh
```

## Что ставится

| Компонент | Назначение |
|-----------|------------|
| Node.js 22 | рантайм панели и CLI |
| `@cloudcli-ai/cloudcli` | веб-панель, порт 3001 |
| `@anthropic-ai/claude-code` и/или `@openai/codex` | агенты |
| Caddy | HTTPS, Let’s Encrypt |
| UFW + Fail2Ban | 22/80/443, защита SSH |
| systemd `claude-panel` | автозапуск |
| `/workspace` | каталог проектов |

После установки: адрес `https://ВАШ-ДОМЕН`, логин `admin`, пароль один раз в конце (копия в `/root/claude-server-info.txt`).

## Команды на сервере

| Команда | Действие |
|---------|----------|
| `ai-status` | состояние панели, Caddy, агентов |
| `ai-login` | вход в Claude / Codex |
| `ai-update` | обновить пакеты |
| `ai-password` | сбросить пароль панели |
| `ai-uninstall` | снять установку |

## Требования

- Ubuntu 22.04 / 24.04, x86_64 или aarch64
- root
- свободное место ≥ 5 ГБ
- свой домен и email для сертификата

## Лицензия

AGPL-3.0-or-later. Если меняете установщик и отдаёте его по сети — публикуйте исходники изменений.
