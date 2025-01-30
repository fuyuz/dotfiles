#!/bin/sh

set -eu

echo "start karabiner-elements setup"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FILES=(karabiner.json)
CONFIG_DIR="$HOME/.config/karabiner"

mkdir -p "$CONFIG_DIR"
for file in "${FILES[@]}"; do
  SOURCE="$SCRIPT_DIR/$file"
  TARGET="$CONFIG_DIR/$file"
  ln -sf "$SOURCE" "$TARGET"
done

echo "finish karabiner-elements setup"
