{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.system.security.sops;
in
{
  options.system.security.sops = with types; {
    enable = mkBoolOpt false "enable sops secrets";
    defaultSopsFile = mkOpt lib.types.path null "default sops file";
  };

  config = mkIf cfg.enable {
    sops = {
      inherit (cfg) defaultSopsFile;
      defaultSopsFormat = "yaml";

      age = {
        generateKey = true;
        keyFile = "${config.users.users.${config.user.name}.home}/.config/sops/age/keys.txt";
        sshKeyPaths = [ "${config.users.users.${config.user.name}.home}/.ssh/id_default" ];
      };
    };

    sops.secrets = { };
  };
}
