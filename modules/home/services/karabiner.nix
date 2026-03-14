{ ... }:
{
  flake.modules.homeManager.karabiner = {
    home.file.".config/karabiner/karabiner.json".source = ./karabiner.json;
  };
}
