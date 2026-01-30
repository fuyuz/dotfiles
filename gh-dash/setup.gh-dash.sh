#!/bin/sh

set -eu

echo "start gh-dash setup"

if ! gh extension list | grep -q "dlvhdr/gh-dash"; then
  echo "installing gh-dash extension..."
  gh extension install dlvhdr/gh-dash
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FILES=(config.yml)
CONFIG_DIR="$HOME/.config/gh-dash"

mkdir -p "$CONFIG_DIR"
for file in "${FILES[@]}"; do
  SOURCE="$SCRIPT_DIR/$file"
  TARGET="$CONFIG_DIR/$file"
  ln -sf "$SOURCE" "$TARGET"
done

echo "finish gh-dash setup"
