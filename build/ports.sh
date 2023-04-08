#!/bin/bash

DEST_SET=0
CONFIG="${CONFIG:-/ports.conf}"

if [[ ! -f "$CONFIG" ]]; then
  echo "You must have a config located at $CONFIG"
  exit 1
fi

CMD=( "$(grep remote $CONFIG | \
  while IFS=' :' read ignoreremote remote port; do 
    if [[ $DEST_SET -eq 0 ]]; then
      printf "/usr/bin/ssh -p $port $remote"
      DEST_SET=1
    fi
  done)" )

CMD=(${CMD[@]} "$(grep user $CONFIG | \
  while IFS=' =' read ignoreuser user; do
    printf " -l $user"
  done)" )

CMD=(${CMD[@]} "$(grep port $CONFIG | \
  while IFS=' :' read ignoreport remote host; do
    printf " -R $remote:$host"
  done)" )

echo "Making connection with command:"
echo "${CMD[@]}"
eval "${CMD[@]}"

# Kill ssh on sigterm
function cleanup() {
  killall ssh
}

trap cleanup SIGTERM
