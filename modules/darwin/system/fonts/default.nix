{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.system.fonts;
in
{
  options.system.fonts = with types; {
    enable = mkBoolOpt false "enable fonts configuration";
  };

  config = mkIf cfg.enable {
    homebrew.casks = mkIf config.tools.homebrew.enable [
      "sf-symbols"
      "font-sf-mono"
      "font-sf-pro"
    ];

    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.caskaydia-cove

      sketchybar-app-font
    ];

    system = {
      defaults = {
        NSGlobalDomain = {
          AppleFontSmoothing = 1;
        };
      };
    };
  };
}
