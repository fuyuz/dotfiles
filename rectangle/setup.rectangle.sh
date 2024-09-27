#!/bin/sh

set -eu

echo "start rectangle setup"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/RectangleConfig.json"
TARGET_DIR="$HOME/Library/Application Support/Rectangle"
TARGET="$TARGET_DIR/RectangleConfig.json"

if [ -f "$CONFIG_FILE" ]; then
  if [ -d "/Applications/Rectangle.app" ]; then
    mkdir -p "$TARGET_DIR"
    ln -sf "$CONFIG_FILE" "$TARGET"
    open -a Rectangle
    echo "Rectangle settings imported from $CONFIG_FILE"
  else
    echo "Rectangle is not installed"
  fi
else
  echo "Configuration file not found"
fi

echo "finish rectangle setup"
