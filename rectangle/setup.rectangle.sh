#!/bin/sh

set -eux

echo "start rectangle setup"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/RectangleConfig.json"

if [ -f "$CONFIG_FILE" ]; then
  if [ -d "/Applications/Rectangle.app" ]; then
    open -a Rectangle --args -import "$CONFIG_FILE"
    echo "Rectangle settings imported from $CONFIG_FILE"
  else
    echo "Rectangle is not installed"
  fi
else
  echo "Configuration file not found"
fi

echo "finish rectangle setup"
