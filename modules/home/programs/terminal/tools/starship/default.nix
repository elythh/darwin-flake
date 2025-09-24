{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.programs.terminal.tools.starship;
in
{
  options.programs.terminal.tools.starship = with types; {
    enable = mkBoolOpt false "enable starship";
  };

  config = mkIf cfg.enable {
    programs.terminal.tools.fastfetch = {
      enable = true;
    };

    programs.eza.enable = true;
    programs.btop.enable = true;

    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        add_newline = false;
        kubernetes.disabled = false;
        direnv.disabled = false;
        format = lib.concatStrings [
          "$directory"
          "$hostname"
          "$git_branch"
          "$git_status"
          ######
          "$fill"
          ######
          "$kubernetes"
          "$battery"
          "$direnv"
          "$cmd_duration"
          "$line_break"
          ######
          "$character"
        ];
        hostname = {
          ssh_only = true;
          style = "fg:purple";
          format = "[@$hostname ]($style)";
        };
        fill = {
          symbol = " ";
        };
      };
    };
  };
}
