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
  cfg = config.programs.terminal.tools.cava;
in
{
  options.programs.terminal.tools.cava = with types; {
    enable = mkBoolOpt false "enable cava";
  };

  config = mkIf cfg.enable {
    programs.cava = {
      enable = true;
      package = pkgs.cava;

      settings = {
        # General
        general = {
          framerate = 120;
          autosens = 4;
          overshoot = 0;
          sensitivity = 50;
          bars = 0;
          bar_width = 6.0;
          bar_spacing = 1.0;
        };

        # Input
        input = {
          method = "portaudio";
          source = "Background Music";
        };

        # Output
        output.channels = "mono";

        # Smoothing
        smoothing = {
          monstercat = 0;
          waves = 0;
          gravity = 100;
        };
      };
    };
  };
}
