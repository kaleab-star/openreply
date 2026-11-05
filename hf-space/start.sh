#!/bin/sh
# One container: Redis (no persistence), the DM worker, the web app, and a daily cron pinger.
redis-server --save "" --appendonly no --daemonize yes
npm run worker &
(
  while true; do
    sleep 86400
    for p in refresh-tokens attach-next-reel snapshot-followers; do
      curl -s -H "Authorization: Bearer $CRON_SECRET" "http://127.0.0.1:7860/api/cron/$p" >/dev/null
    done
  done
) &
exec npx next start -p 7860 -H 0.0.0.0
