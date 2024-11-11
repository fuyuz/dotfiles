#!/bin/sh

set -eu

echo "start yabai setup"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FILES=(yabairc)
CONFIG_DIR="$HOME/.config/yabai"

mkdir -p "$CONFIG_DIR"
for file in "${FILES[@]}"; do
  SOURCE="$SCRIPT_DIR/$file"
  TARGET="$CONFIG_DIR/$file"
  chmod +x "$SOURCE"
  ln -sf "$SOURCE" "$TARGET"
done

yabai --start-service

echo "finish yabai setup"
