{ config, ... }:
{
  flake = {
    meta.users.default = {
      username = "elyth";
      name = "Gwenc'hlan";
      authorizedKeys = [
      ];
    };

    modules.nixos.nixos =
      { pkgs, ... }:
      {
        users = {
          users = {
            ${config.flake.meta.users.default.username} = {
              isNormalUser = true;
              description = config.flake.meta.users.default.name;
              shell = pkgs.fish;
              extraGroups = [
                "wheel"
                "input"
              ];
              openssh.authorizedKeys.keys = config.flake.meta.users.default.authorizedKeys;
            };

            root = {
              hashedPassword = null;
              # uncomment the line below to be able to access the root user over ssh too
              # openssh.authorizedKeys.keys = config.flake.meta.users.default.authorizedKeys;
            };
          };
        };
      };
  };
}
