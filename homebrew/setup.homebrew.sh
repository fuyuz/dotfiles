#!/bin/bash

set -eu

echo "start homebrew setup"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$SCRIPT_DIR/Brewfile"

if [ $(uname) = Darwin ]; then
  if ! type brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "nothing happened since homebrew is already installed."
  fi

  brew bundle --file=$BREWFILE
fi

echo "finish homebrew setup"
