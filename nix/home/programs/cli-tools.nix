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
    version = "unstable-2026-02-10";
    src = pkgs.fetchFromGitHub {
      owner = "ushironoko";
      repo = "octorus";
      rev = "f23068364b89934b080a1ceaf2fc22d09f9d915c";
      hash = "sha256-sh5z3y+q2cAt8IXw5xHRHSuDMxPB+J6faRojSAhQJtk=";
    };
    cargoHash = "sha256-ql2e4uhST6sSgqm8YhcdF0GScj8hjwcioIQvcEff7Wg=";
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
    jujutsu
    jjui
    awscli2

    # JavaScript runtime
    bun

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
