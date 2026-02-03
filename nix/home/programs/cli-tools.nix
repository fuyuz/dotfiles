{ pkgs, lib, inputs, system, ... }:

let
  octorus = pkgs.rustPlatform.buildRustPackage rec {
    pname = "octorus";
    version = "unstable-2025-01-31";
    src = pkgs.fetchFromGitHub {
      owner = "ushironoko";
      repo = "octorus";
      rev = "114497f889b664c63f476a1460ca4a088e4822e1";
      hash = "sha256-SZNnmqCX80taO+RY8eEM0JUKBBXZSktbyJUoD2zQVzw=";
    };
    cargoHash = "sha256-yB3GmRkxuaPX6+TTY1/xFv3sP0t4ZXxZgoDh7BnWGZo=";
    meta = {
      description = "TUI PR review tool for GitHub";
      homepage = "https://github.com/ushironoko/octorus";
      license = lib.licenses.mit;
      mainProgram = "or";
    };
  };
in
{
  home.packages = with pkgs; [
    # Terminal
    inputs.wezterm.packages.${system}.default
    zsh-abbr

    # File utilities
    fd
    ripgrep
    tree
    trash-cli

    # JSON/YAML processing
    jq
    yq

    # System monitoring
    htop

    # Misc utilities
    wget
    curl
    coreutils
    gnused
    gawk

    # Development tools
    gh
    gh-dash
    awscli2

    # JavaScript runtime
    bun

    # AI coding tools
    codex
    claude-code
    opencode

    # Media tools
    ffmpeg
    imagemagick

    # Documentation
    glow


    # GitHub PR review TUI
    octorus

    # Archive tools
    unzip
    zip
  ];

  programs = {
    # Fuzzy finder
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd --type f --hidden --follow --exclude .git";
      defaultOptions = [
        "--height 40%"
        "--layout=reverse"
        "--border"
      ];
    };

    # Modern ls replacement
    eza = {
      enable = true;
      enableZshIntegration = true;
      icons = "auto";
      git = true;
    };

    # System monitor
    btop = {
      enable = true;
      settings = {
        color_theme = "onedark";
        theme_background = false;
      };
    };

    # Bat - cat with syntax highlighting
    bat = {
      enable = true;
      config = {
        theme = "OneHalfDark";
        style = "numbers,changes,header";
      };
    };

    # Directory jumper
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    # Lazygit - terminal UI for git
    lazygit.enable = true;

    # Direnv - per-directory environment
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };

  # Run 'or init' on first octorus installation
  home.activation.octorusInit = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "$HOME/.config/octorus" ]; then
      run ${octorus}/bin/or init || true
    fi
  '';
}
