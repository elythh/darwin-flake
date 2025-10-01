{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.programs.terminal.tools.atuin;
in
{
  options.programs.terminal.tools.atuin = with types; {
    enable = mkBoolOpt false "enable atuin";
  };

  config = mkIf cfg.enable {
    programs.atuin = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        style = "compact";
        show_tabs = false;
        show_help = false;
        enter_accept = true;
      };
    };
  };
}
