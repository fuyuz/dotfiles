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
      # zsh-abbr
      ABBR_SET_EXPANSION_CURSOR=1
      source ${pkgs.zsh-abbr}/share/zsh/zsh-abbr/zsh-abbr.zsh
      ABBR_FORCE=1 ABBR_QUIET=1 abbr load

      # Load local zshrc if it exists
      [[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

      # gh completion
      eval "$(gh completion -s zsh)"

      # jj completion
      eval "$(jj util completion zsh)"

      # pr function for octorus
      pr() {
        local repo
        repo=$(gh repo view --json owner,name -q ".owner.login + \"/\" + .name") || return 1
        local pr_number
        if [ -n "$1" ]; then
          pr_number="$1"
        else
          pr_number=$(gh pr view --json number -q ".number" 2>/dev/null) || {
            echo "PR番号を取得できませんでした。PR番号を指定してください。"
            return 1
          }
        fi
        or --repo "$repo" --pr "$pr_number"
      }
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
    };
  };
}
