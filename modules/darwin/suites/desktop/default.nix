{
  options,
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.suites.desktop;
in
{
  options.suites.desktop = with types; {
    enable = mkBoolOpt false "enable desktop suite";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      raycast
      switchaudio-osx
      hellwal
      pkgs.${namespace}.helium
    ];

    homebrew.casks = [
      "background-music"
      "zen"
    ];

    wms.aerospace = {
      enable = true;
    };
  };
}
