{ config, ... }:
{
  flake.modules.darwin.desktop =
    { pkgs, ... }:
    {
      imports = with config.flake.modules.darwin; [
        aerospace
      ];

      environment.systemPackages = with pkgs; [
        raycast
        switchaudio-osx
        hellwal
      ];

      homebrew.casks = [
        "steam"
        "zen"
        "karabiner-elements"
        "leader-key"
      ];
    };
}
