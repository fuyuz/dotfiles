{ config, pkgs, ... }:

{
  # JetBrains Toolbox CLI scripts (was in a Toolbox-generated ~/.zprofile)
  home.sessionPath = [
    "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
  ];

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

      # Find usage-limited Claude panes in herdr and queue a message 5 min after each limit resets
      claude-continue-on-reset() {
        local msg="''${1:-continue}" found=0 pane screen hit tstr reset now delay
        for pane in $(herdr agent list 2>/dev/null | jq -r '.result.agents[] | select(.agent == "claude") | .pane_id'); do
          screen=$(herdr pane read "$pane" --lines 40 2>/dev/null) || continue
          hit=$(grep -iE 'limit' <<< "$screen" | grep -iE 'reset' | tail -1)
          [[ -z "$hit" ]] && continue
          found=1
          tstr=$(grep -ioE '[0-9]{1,2}(:[0-9]{2})?(am|pm)' <<< "$hit" | tail -1)
          tstr="''${tstr:l}"
          if [[ -z "$tstr" ]]; then
            echo "$pane: usage limit中ですが解除時刻を検出できませんでした"
            continue
          fi
          [[ "$tstr" == *:* ]] || tstr=$(sed -E 's/(am|pm)/:00\1/' <<< "$tstr")
          reset=$(date -d "$tstr" +%s 2>/dev/null)
          if [[ -z "$reset" ]]; then
            echo "$pane: 解除時刻のパースに失敗しました ($tstr)"
            continue
          fi
          now=$(date +%s)
          (( reset <= now )) && (( reset += 86400 ))
          delay=$(( reset - now + 300 ))
          ( sleep $delay && herdr pane send-text "$pane" "$msg" && herdr pane send-keys "$pane" enter ) &> /dev/null &!
          echo "$pane: $(date -d @$reset +%H:%M) 解除 → $(date -d @$(( reset + 300 )) +%H:%M) に「$msg」を送信予約"
        done
        (( found )) || echo "usage limit中のclaudeペインは見つかりませんでした"
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
