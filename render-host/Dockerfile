FROM node:20-slim
RUN apt-get update && apt-get install -y --no-install-recommends redis-server git curl ca-certificates openssl && rm -rf /var/lib/apt/lists/*
WORKDIR /app
# Code comes from GitHub; bump CACHEBUST to rebuild with the latest commit.
ARG CACHEBUST=1
RUN git clone --depth 1 https://github.com/kaleab-star/openreply.git .
RUN npm ci
# Build needs placeholder env only; real values come from Space secrets at runtime.
ENV DATABASE_URL=postgresql://x:x@localhost:5432/x NEXTAUTH_SECRET=build ENCRYPTION_KEY=0000000000000000000000000000000000000000000000000000000000000000
RUN npm run build
COPY start.sh /start.sh
RUN chmod +x /start.sh
ENV NODE_ENV=production PORT=7860 REDIS_URL=redis://127.0.0.1:6379
EXPOSE 7860
CMD ["/start.sh"]
