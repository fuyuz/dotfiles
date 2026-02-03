{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;

    ignores = [
      ".DS_Store"
      "*.swp"
      "*.swo"
      ".idea/"
      ".vscode/"
      ".claude/settings.local.json"
      "node_modules/"
      ".env"
      ".env.local"
    ];

    settings = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      rebase.autoStash = true;
      fetch.prune = true;
      diff.colorMoved = "default";
      merge.conflictstyle = "diff3";

      include.path = "~/.gitconfig.local";

      alias = {
        co = "checkout";
        br = "branch";
        ci = "commit";
        st = "status";
        sw = "switch";
        unstage = "reset HEAD --";
        last = "log -1 HEAD";
        visual = "!gitk";
        lg = "log --oneline --graph --decorate";
      };

      credential.helper = "!${pkgs.gh}/bin/gh auth git-credential";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      light = false;
      side-by-side = true;
      line-numbers = true;
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
    };
  };
}
