{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.themes.tokyonight-moon;
in
{
  options.themes.tokyonight-moon = with types; {
    enable = mkBoolOpt false "enable tokyonight-moon";
  };

  config = mkIf cfg.enable {
    home.programs.ghostty.settings = mkIf config.programs.graphical.ghostty.enable {
      theme = "TokyoNight";
    };

    home.programs.opencode = mkIf config.programs.terminal.opencode.enable {
      settings = {
        theme = "tokyonight";
      };
    };
  };
}
