#!/usr/bin/sh

/usr/bin/pgbouncer /etc/pgbouncer/pgbouncer.ini &
PG_BOUNCER_PID=$!

echo "Pg bouncer is PID: ${PG_BOUNCER_PID}"

{
  inotifywait -r -m -e modify -e close_write -e move -e move_self -e delete /etc/pgbouncer |
     while read -r file_path file_event file_name; do
         echo ${file_path}${file_name} event: ${file_event}
         echo "Forcing pg bounder configuration reload..."
         kill -1 $PG_BOUNCER_PID
     done
} &

wait

