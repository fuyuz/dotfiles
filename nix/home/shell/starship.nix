{ ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      command_timeout = 1000;

      directory = {
        style = "fg:blue";
        format = "[$path]($style) ";
        truncation_length = 4;
        truncation_symbol = "...";
        truncate_to_repo = false;
      };

      cmd_duration = {
        show_milliseconds = true;
        format = "[󱫌 $duration]($style) ";
      };

      git_branch = {
        format = "[$symbol$branch]($style) ";
      };

      git_status = {
        format = "([$all_status$ahead_behind]($style)) ";
      };
    };
  };
}
