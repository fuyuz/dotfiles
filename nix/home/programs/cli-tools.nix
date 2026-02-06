{
  pkgs,
  lib,
  inputs,
  system,
  ...
}:

let
  octorus = pkgs.rustPlatform.buildRustPackage rec {
    pname = "octorus";
    version = "unstable-2025-02-04";
    src = pkgs.fetchFromGitHub {
      owner = "ushironoko";
      repo = "octorus";
      rev = "4f8bf1856ad25e90f1fb57055bb226bb33d39cd6";
      hash = "sha256-gI+KyamMp7saKzVABPMhM2bE2iFwNmEMnVQAVa1wcY0=";
    };
    cargoHash = "sha256-CkUdgMq9YbH7KvNbAGDun/XZbRs4nbkX4/ihypkeyAg=";
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

    # Development tools
    gh
    gh-dash
    awscli2

    # JavaScript runtime
    bun

    # AI coding tools
    codex
    inputs.llm-agents.packages.${system}.claude-code
    inputs.llm-agents.packages.${system}.opencode

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
