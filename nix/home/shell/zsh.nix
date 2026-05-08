{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      save = 10000;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      share = true;
    };

    sessionVariables = {
      EDITOR = "nvim";
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };

    shellAliases = {
      # eza aliases (ls replacement)
      ls = "eza";
      l = "eza -l";
      la = "eza -la";
      ll = "eza -l";
      lla = "eza -la";

      # vim
      v = "nvim";
      vim = "nvim";

      # safety aliases
      rm = "trash";
      cp = "cp -i";
      mv = "mv -i";
      mkdir = "mkdir -p";

      # cat/top replacements
      cat = "bat --paging=never";
      top = "btop";

    };

    initContent = ''
      # Homebrew
      export PATH="/opt/homebrew/bin:$PATH"

      # zsh-abbr
      ABBR_SET_EXPANSION_CURSOR=1
      source ${pkgs.zsh-abbr}/share/zsh/zsh-abbr/zsh-abbr.zsh
      ABBR_FORCE=1 ABBR_QUIET=1 abbr load

      # Nix GitHub API auth (avoids rate limiting on flake update)
      if command -v gh &>/dev/null && gh auth token &>/dev/null; then
        export NIX_CONFIG="access-tokens = github.com=$(gh auth token)"
      fi

      # Load local zshrc if it exists
      [[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

      # gh completion
      eval "$(gh completion -s zsh)"

      # jj completion
      eval "$(jj util completion zsh)"
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
    };
  };
}
