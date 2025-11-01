{ lib, config, inputs, ... }:
let
  mkNixos =
    system: cls: name:
    lib.nixosSystem {
      inherit system;
      modules = [
        config.flake.modules.nixos.${cls}
        config.flake.modules.nixos.${name}
        {
          home-manager.users.${config.flake.meta.users.default.username}.imports = [
            config.flake.modules.homeManager.homeManager
          ];

          networking.hostName = lib.mkDefault name;
          nixpkgs.hostPlatform = lib.mkDefault system;
          # This value determines the NixOS release from which the default
          # settings for stateful data, like file locations and database versions
          # on your system were taken. It‘s perfectly fine and recommended to leave
          # this value at the release version of the first install of this system.
          # Before changing this value read the documentation for this option
          # (e.g. man configuration.nix or on https://search.nixos.org/options?&show=system.stateVersion&from=0&size=50&sort=relevance&type=packages&query=stateVersion).
          system.stateVersion = "26.05";
        }
      ];
    };

  mkDarwin =
    system: cls: name:
    inputs.darwin.lib.darwinSystem {
      modules = [
        config.flake.modules.darwin.${cls}
        config.flake.modules.darwin.${name}
        {
          home-manager.users.${config.flake.meta.users.default.username}.imports = [
            config.flake.modules.homeManager.homeManager
          ];

          networking.hostName = lib.mkDefault name;
          nixpkgs.hostPlatform = lib.mkDefault system;
          system.stateVersion = 5;
        }
      ];
    };

  linux = mkNixos "x86_64-linux" "nixos";
  linux-arm = mkNixos "aarch64-linux" "nixos";

  wsl = mkNixos "x86_64-linux" "wsl";

  darwin = mkDarwin "aarch64-darwin" "darwin";
in
{
  flake.lib = {
    mkSystems = {
      inherit
        linux
        linux-arm

        wsl

        darwin
        ;
    };
  };
}
