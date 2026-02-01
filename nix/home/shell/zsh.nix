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

      # wezterm
      wi = "wezterm imgcat";

      # lazygit
      lg = "lazygit";

      # claude
      yolo = "claude --dangerously-skip-permissions";
      cc = "claude code";

      # opencode
      oc = "opencode";

      # git abbreviations as aliases (since zsh-abbr is not in home-manager)
      g = "git";
      gp = "git push";
      gpf = "git push --force-with-lease";
      gs = "git switch";
      gbc = "git switch -c";
      gco = "git checkout";
      gfa = "git fetch --all";

      # github cli
      ghp = "gh pr";
      ghpc = "gh pr create";
      ghpl = "gh pr list";
      ghpv = "gh pr view";
      ghps = "gh pr status";
      ghi = "gh issue";
      ghil = "gh issue list";
      ghiv = "gh issue view";
      ghis = "gh issue status";
      ghpr = "gh search prs --review-requested=@me --state=open";
      gd = "gh dash";
    };

    initContent = ''
      # Load local zshrc if it exists
      [[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

      # gh completion
      eval "$(gh completion -s zsh)"

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
