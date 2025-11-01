{ config, ... }:
let
  username = config.flake.meta.users.default.username;
in
{
  flake.modules.darwin.darwin = {
    users.users.${username}.home = "/Users/${username}";
  };
}
