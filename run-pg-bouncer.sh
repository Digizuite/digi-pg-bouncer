#!/usr/bin/sh

/usr/bin/pgbouncer /etc/pgbouncer/pgbouncer.ini &
PG_BOUNCER_PID=$!

echo "Pg bouncer is PID: ${PG_BOUNCER_PID}"

{
  inotifywait -r -m -e modify /etc/pgbouncer |
     while read -r _ _ _; do
         echo "Forcing pg bounder configuration reload..."
         kill -1 $PG_BOUNCER_PID
     done
} &

wait

