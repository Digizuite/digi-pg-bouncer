#!/usr/bin/sh

/usr/bin/pgbouncer /etc/pgbouncer/pgbouncer.ini &
PG_BOUNCER_PID=$!

{
  inotifywait -r -m -e modify /etc/pgbouncer |
     while read file_path file_event file_name; do
         echo ${file_path}${file_name} event: ${file_event}
         kill -1 $PG_BOUNCER_PID
     done
} &

wait

