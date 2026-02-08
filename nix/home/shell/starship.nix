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

      custom.jj = {
        when = "jj --ignore-working-copy root";
        ignore_timeout = true;
        symbol = "jj ";
        style = "bold purple";
        format = "[$symbol$output]($style) ";
        command = ''
          jj log --revisions @ --limit 1 --ignore-working-copy --no-graph --color always --template '
            separate(" ",
              bookmarks.map(|x| truncate_end(10, x.name(), "...")).join(" "),
              tags.map(|x| truncate_end(10, x.name(), "...")).join(" "),
              surround("\"", "\"", truncate_end(24, description.first_line(), "...")),
              if(conflict, "conflict"),
              if(divergent, "divergent"),
              if(hidden, "hidden"),
            )
          '
        '';
      };

      git_branch.disabled = true;
      git_commit.disabled = true;
      git_metrics.disabled = true;
      git_state.disabled = true;
      git_status.disabled = true;
    };
  };
}
