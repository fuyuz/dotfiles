{
  pkgs,
  inputs,
  system,
  ...
}:

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
    terraform
    actionlint
    devenv

    # JavaScript runtime
    bun
    playwright-test

    # Gleam (compiler ships its own LSP via `gleam lsp`)
    gleam
    beam27Packages.erlang

    # Neovim treesitter
    tree-sitter

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
      package = pkgs.jdk21;
    };
  };
}
