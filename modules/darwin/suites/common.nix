{ config, inputs, ... }:
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
        inputs.lfk.packages.${pkgs.system}.default
      ];

      programs.fish.enable = true;
    };
}
