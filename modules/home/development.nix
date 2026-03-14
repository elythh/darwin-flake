{ config, ... }:
{
  flake.modules.homeManager.development = {
    imports = with config.flake.modules.homeManager; [
      mise
    ];
  };
}
