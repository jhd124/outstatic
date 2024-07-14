FROM node:20-slim AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

FROM base AS builder
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile
RUN pnpm run -r build
RUN pnpm deploy --filter=china-travel --prod /prod/china-travel

FROM base AS runner
WORKDIR /app
COPY --from=builder /prod/china-travel /app
ENV NODE_ENV production

EXPOSE 3000
ENV PORT 3000

CMD ["pnpm", "start"]