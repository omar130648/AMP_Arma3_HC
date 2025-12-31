#!/bin/bash
set -e

SERVER_IP="${HC_SERVER_IP}"
SERVER_PORT="${HC_SERVER_PORT}"
CLIENT_MODS="${CLIENT_MODS}"
CDLC="${CDLC}"
EXTRA_ARGS="${HC_EXTRA_ARGS}"

cd arma3hc/233780

CMD="./arma3server_x64 -client -connect=${SERVER_IP} -port=${SERVER_PORT}"

if [ -n "$CLIENT_MODS" ]; then
  CMD="$CMD -mod=${CLIENT_MODS}"
fi

if [ -n "$CDLC" ]; then
  CMD="$CMD -cdlc=${CDLC}"
fi

CMD="$CMD ${EXTRA_ARGS}"

echo "Starting Arma 3 Headless Client:"
echo "$CMD"

exec $CMD
