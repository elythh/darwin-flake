{ config, ... }:
let
  username = config.flake.meta.users.default.username;
in
{
  flake = {
    darwinConfigurations.voidling = config.flake.lib.mkSystems.darwin "voidling";

    modules.darwin.voidling =
      { pkgs, ... }:
      {
        imports = with config.flake.modules.darwin; [
          laptop
          common
          social
          development
          desktop
        ];

        environment.systemPackages = [ pkgs.openvpn ];

        home-manager.users.${username}.imports = with config.flake.modules.homeManager; [
          common
        ];
      };
  };
}
