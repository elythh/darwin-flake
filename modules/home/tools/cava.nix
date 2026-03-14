{ ... }:
{
  flake.modules.homeManager.cava =
    { pkgs, ... }:
    {
      programs.cava = {
        enable = true;
        package = pkgs.cava;

        settings = {
          general = {
            framerate = 120;
            autosens = 4;
            overshoot = 0;
            sensitivity = 50;
            bars = 0;
            bar_width = 6.0;
            bar_spacing = 1.0;
          };

          input = {
            method = "portaudio";
            source = "Background Music";
          };

          output.channels = "mono";

          smoothing = {
            monstercat = 0;
            waves = 0;
            gravity = 100;
          };
        };
      };
    };
}
