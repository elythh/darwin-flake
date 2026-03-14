{ self, config, ... }:
let
  username = config.flake.meta.users.default.username;
in
{
  flake.modules.darwin.darwin = {
    users.users.${username}.home = "/Users/${username}";
    system.primaryUser = username;
    programs.fish.enable = true;
    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = builtins.attrValues self.overlays;
  };
}
