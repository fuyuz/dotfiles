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
    version = "0.5.7";
    src = pkgs.fetchFromGitHub {
      owner = "ushironoko";
      repo = "octorus";
      rev = "dde8a6e10b21469b847e669caf6ffd47284e4bf2";
      hash = "sha256-lwtS2wInfxdS62uXHSOV/81dd7ayiNnPCqcZPQLyqXs=";
    };
    cargoHash = "sha256-I7AUA6zdHkZt9GWtDoXV4xwGN5hYsA3H6B48krss1EA=";
    nativeBuildInputs = [ pkgs.git ];
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
    zsh-abbr

    # File utilities
    fd
    ripgrep
    tree
    trash-cli

    # JSON processing
    jq

    # System monitoring
    htop

    # Misc utilities
    wget
    curl
    coreutils

    # Development tools
    gh
    gh-dash
    jujutsu
    jjui
    awscli2
    actionlint

    # JavaScript runtime
    bun
    playwright-test

    # AI coding tools
    codex
    gemini-cli
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
