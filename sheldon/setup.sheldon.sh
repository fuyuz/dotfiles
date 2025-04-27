#!/bin/sh

set -eu

echo "start sheldon setup"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FILES=(plugins.toml zsh/abbr.post.zsh zsh/fzf.post.zsh)
CONFIG_DIR="$HOME/.config/sheldon"

mkdir -p "$CONFIG_DIR"
mkdir -p "$CONFIG_DIR/zsh"
for file in "${FILES[@]}"; do
  SOURCE="$SCRIPT_DIR/$file"
  TARGET="$CONFIG_DIR/$file"
  ln -sf "$SOURCE" "$TARGET"
done

echo "finish sheldon setup"
