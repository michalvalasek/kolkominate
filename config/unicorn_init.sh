#!/bin/sh

set -e
# Example init script, this can be used with nginx, too,
# since nginx and unicorn accept the same signals

# Feel free to change any of the following variables for your app:
TIMEOUT=${TIMEOUT-60}
APP_ROOT=/kolkominate
PID=$APP_ROOT/tmp/pids/unicorn.pid
CMD="$APP_ROOT/bin/unicorn_rails -c $APP_ROOT/config/unicorn.rb -E production -D"
#INIT_CONF=$APP_ROOT/config/init.conf
action="$1"
set -u

#test -f "$INIT_CONF" && . $INIT_CONF

$CMD
