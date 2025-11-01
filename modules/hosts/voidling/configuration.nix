
{ config, ... }:
{
  flake = {
    darwinConfigurations.voidling = config.flake.lib.mkSystems.darwin "voidling";

    modules.darwin.voidling = {
      imports = with config.flake.modules.darwin; [
        laptop
      ];
    };
  };
}
