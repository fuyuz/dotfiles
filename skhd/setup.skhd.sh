#!/bin/sh

set -eu

echo "start skhd setup"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FILES=(skhdrc)
CONFIG_DIR="$HOME/.config/skhd"

mkdir -p "$CONFIG_DIR"
for file in "${FILES[@]}"; do
  SOURCE="$SCRIPT_DIR/$file"
  TARGET="$CONFIG_DIR/$file"
  chmod +x "$SOURCE"
  ln -sf "$SOURCE" "$TARGET"
done

skhd --start-service

echo "finish skhd setup"
