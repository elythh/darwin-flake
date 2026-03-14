{ ... }:
{
  flake.modules.homeManager.starship =
    { lib, ... }:
    {
      programs.eza.enable = true;
      programs.btop.enable = true;

      programs.starship = {
        enable = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
        settings = {
          add_newline = false;
          kubernetes.disabled = false;
          direnv.disabled = false;
          format = lib.concatStrings [
            "$directory"
            "$hostname"
            "$git_branch"
            "$git_status"
            "$fill"
            "$kubernetes"
            "$battery"
            "$direnv"
            "$cmd_duration"
            "$line_break"
            "$character"
          ];
          hostname = {
            ssh_only = true;
            style = "fg:purple";
            format = "[@$hostname ]($style)";
          };
          fill.symbol = " ";
        };
      };
    };
}
