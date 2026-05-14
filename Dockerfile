FROM node:24-slim AS builder

RUN apt-get update && apt-get install -y \
    git \
    python3 \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g pnpm@10.29.1

WORKDIR /workspace

ARG AGENT_NATIVE_REF=main
RUN git clone --depth 1 --branch ${AGENT_NATIVE_REF} https://github.com/BuilderIO/agent-native.git .

# Install all workspace deps — also builds @agent-native/core via postinstall
RUN pnpm install --frozen-lockfile

# Build the starter template (outputs to templates/starter/.output)
RUN pnpm --filter starter run build

FROM node:24-slim AS production

RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=builder /workspace/templates/starter/.output ./.output

EXPOSE 3000

ENV NODE_ENV=production
ENV PORT=3000

CMD ["node", ".output/server/index.mjs"]
