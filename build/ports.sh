#!/bin/bash

DEST_SET=0
CONFIG="/ssh/ports.conf"

CMD=( "$(grep remote $CONFIG | \
  while IFS=' :' read ignoreremote remote port; do 
    if [[ $DEST_SET -eq 0 ]]; then
      CMD=( 'ssh' '-p' "$port" "$remote" )
      DEST_SET=1
      echo "${CMD[@]}"
    fi
  done)" )

CMD=(${CMD[@]} "$(grep user $CONFIG | \
  while IFS=' =' read ignoreuser user; do
    CMD=( ${CMD[@]} '-l' "$user" )
    echo "${CMD[@]}"
  done)" )

CMD=(${CMD[@]} "$(grep port $CONFIG | \
  while IFS=' :' read ignoreport remote host; do
    CMD=( ${CMD[@]} '-R' "$remote:$host" )
    echo "${CMD[@]}"
  done)" )

exec eval "${CMD[@]}"
