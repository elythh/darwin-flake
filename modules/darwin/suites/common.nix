{ config, ... }:
{
  flake.modules.darwin.common =
    { pkgs, ... }:
    {
      imports = with config.flake.modules.darwin; [
        homebrew
        fonts
        input
        interface
        networking
        nix-config
      ];

      environment.systemPackages = with pkgs; [
        unar
        automake
        jq
        nixd
        nixfmt
        wget
      ];

      programs.fish.enable = true;
    };
}
