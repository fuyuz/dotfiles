#!/bin/sh

set -eu

echo "start wezterm setup"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FILES=(wezterm.lua)
CONFIG_DIR="$HOME/.config/wezterm"

mkdir -p "$CONFIG_DIR"
for file in "${FILES[@]}"; do
  SOURCE="$SCRIPT_DIR/$file"
  TARGET="$CONFIG_DIR/$file"
  ln -sf "$SOURCE" "$TARGET"
done

echo "finish wezterm setup"
