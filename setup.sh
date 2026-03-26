#!/bin/bash

set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILE="${PROFILE:-personal}"

echo "=== dotfiles setup ==="

# Check if Nix is installed
if command -v nix &> /dev/null; then
    echo "Nix detected. Using nix-darwin + home-manager..."
    echo "Profile: $PROFILE"

    # Check if darwin-rebuild is available
    if command -v darwin-rebuild &> /dev/null; then
        echo "Running darwin-rebuild switch..."
        cd "$SCRIPT_DIR" && exec ./scripts/darwin-switch
    else
        echo "darwin-rebuild not found. Running initial nix-darwin installation..."

        host="$(scutil --get LocalHostName 2>/dev/null || hostname -s || echo "")"
        if [ -z "$host" ]; then
            echo "Error: could not determine hostname" >&2
            exit 1
        fi
        user="${USER:-$(id -un)}"

        # First build the system
        HOSTNAME="$host" USER="$user" nix build "$SCRIPT_DIR#darwinConfigurations.$PROFILE.system" --extra-experimental-features "nix-command flakes" --impure

        # Install nix-darwin (requires sudo for system activation)
        sudo HOSTNAME="$host" USER="$user" ./result/sw/bin/darwin-rebuild switch --flake "$SCRIPT_DIR#$PROFILE" --impure
    fi

    echo "=== Nix setup complete ==="
else
    echo "Nix not detected. Using traditional symlink setup..."
    echo "To use Nix, install Determinate Nix first:"
    echo "  https://install.determinate.systems/determinate-pkg/stable/Universal"
    echo ""
    echo "Running legacy setup scripts..."

    FILES=(
        homebrew/setup.homebrew.sh
        sheldon/setup.sheldon.sh
        starship/setup.starship.sh
        wezterm/setup.wezterm.sh
        nvim/setup.nvim.sh
        zsh/setup.zsh.sh
        ideavim/setup.ideavim.sh
        claude/setup.claude.sh
        gh-dash/setup.gh-dash.sh
    )

    for file in "${FILES[@]}"; do
        if [ -f "$SCRIPT_DIR/$file" ]; then
            sh "$SCRIPT_DIR/$file"
        fi
    done

    echo "=== Legacy setup complete ==="
fi
