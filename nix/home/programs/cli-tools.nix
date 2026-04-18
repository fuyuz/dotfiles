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
    version = "0.5.8";
    src = pkgs.fetchFromGitHub {
      owner = "ushironoko";
      repo = "octorus";
      rev = "v0.5.8";
      hash = "sha256-hesjvtz+kRoUS0hH2NlpLDZKlnivxMNPATOgiW91sTk=";
    };
    cargoHash = "sha256-ssH6GZFQT5mNRn7sYgDWZq9lunTLfCplHTtg5A+rqek=";
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
    tig
    jujutsu
    jjui
    awscli2
    google-cloud-sdk
    actionlint
    devenv

    # JavaScript runtime
    bun
    playwright-test

    # AI coding tools
    inputs.llm-agents.packages.${system}.codex
    inputs.llm-agents.packages.${system}.claude-code
    inputs.llm-agents.packages.${system}.junie
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

    # Atuin - shell history
    atuin = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        filter_mode = "directory";
        filter_mode_shell_up_key_binding = "directory";
        search_mode = "fuzzy";
        max_history_length = 50000;
        sync.records = false;
      };
      flags = [ "--disable-up-arrow" ];
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    java = {
      enable = true;
      package = pkgs.jdk17;
    };
  };

  # Run 'or init' on first octorus installation
  home.activation.octorusInit = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "$HOME/.config/octorus" ]; then
      run ${octorus}/bin/or init || true
    fi
  '';
}
