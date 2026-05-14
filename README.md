# agent-native — Railway Template

Deploy the [agent-native](https://github.com/BuilderIO/agent-native) **Starter** template on Railway in one click.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template?template=https://github.com/YOUR_GITHUB_USERNAME/agent-native-railway)

> **Replace** `YOUR_GITHUB_USERNAME` in the badge URL above once you push this repo to GitHub.

---

## What gets deployed

- **agent-native Starter** — a full-stack AI-native app built on React Router 7, Nitro, and Tailwind CSS
- Powered by **Claude** (Anthropic) for agent/chat features
- SQLite by default; drop in a Railway **Postgres** plugin for production persistence

## Quick start

### 1. Push this repo to GitHub

```bash
git remote add origin https://github.com/YOUR_USERNAME/agent-native-railway.git
git push -u origin main
```

### 2. Deploy on Railway

Click the **Deploy on Railway** button above, or:

1. Go to [railway.com](https://railway.com) → **New Project** → **Deploy from GitHub repo**
2. Select this repository
3. Railway will auto-detect the `Dockerfile` and start the build

### 3. Add a Postgres database (recommended)

In your Railway project:
- Click **+ New** → **Database** → **PostgreSQL**
- Railway automatically sets `DATABASE_URL` on your app service — no extra config needed

### 4. Set required environment variables

In your service's **Variables** tab, add:

| Variable | Value |
|---|---|
| `ANTHROPIC_API_KEY` | Get from [console.anthropic.com](https://console.anthropic.com) |
| `BETTER_AUTH_SECRET` | Run `openssl rand -hex 32` |
| `A2A_SECRET` | Run `openssl rand -hex 32` |
| `APP_URL` | Your Railway public domain, e.g. `https://xxx.up.railway.app` |
| `BETTER_AUTH_URL` | Same as `APP_URL` |

All other variables in [`.env.example`](.env.example) are optional.

### 5. Generate your domain and open the app

In your service → **Settings** → **Networking** → **Generate Domain**.

---

## Switching to a different template

The `Dockerfile` clones the agent-native monorepo and builds the `starter` template. To deploy a different template (e.g. `mail`, `calendar`, `content`):

1. Open `Dockerfile`
2. Change the `pnpm --filter starter run build` line to e.g. `pnpm --filter mail run build`
3. Update the `COPY` path from `templates/starter/.output` to `templates/mail/.output`
4. Push — Railway will rebuild automatically

---

## Build details

| Step | Command |
|---|---|
| Clone | `git clone https://github.com/BuilderIO/agent-native.git` |
| Install | `pnpm install --frozen-lockfile` |
| Build | `pnpm --filter starter run build` |
| Start | `node .output/server/index.mjs` |

- **Node.js**: 24 (slim)
- **Package manager**: pnpm 10.29.1
- **Health check**: `GET /_agent-native/ping`
- **Port**: `3000` (set via `PORT` env var)

---

## Useful links

- [agent-native docs](https://www.agent-native.com/docs)
- [agent-native GitHub](https://github.com/BuilderIO/agent-native)
- [Railway docs](https://docs.railway.com)
