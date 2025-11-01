{ config, inputs, ... }:
{
  flake.modules = {
    nixos.nixos = {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];

      home-manager = {
        backupFileExtension = "backup";
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    };
    darwin.darwin = {
      imports = [
        inputs.home-manager.darwinModules.home-manager
      ];

      home-manager = {
        backupFileExtension = "backup";
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    };

    homeManager.homeManager =
      {
        home =
          let
            inherit (config.flake.meta.users.default) username;
          in
          {
            inherit username;
            stateVersion = "26.05";
          };
      };
  };
}
