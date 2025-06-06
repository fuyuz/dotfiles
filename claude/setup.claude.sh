#!/bin/bash

set -eu

echo "start claude setup"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SETTINGS_FILE="$SCRIPT_DIR/settings.json"

if [ ! -d "$HOME/.claude" ]; then
  mkdir -p "$HOME/.claude"
  echo "created ~/.claude directory"
fi

if [ -f "$SETTINGS_FILE" ]; then
  cp "$SETTINGS_FILE" "$HOME/.claude/settings.json"
  echo "copied settings.json to ~/.claude/"
else
  echo "settings.json not found in $SCRIPT_DIR"
  exit 1
fi

echo "finish claude setup"