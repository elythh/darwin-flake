{
  config,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.user;
in
{
  options.user = with types; {
    name = mkOpt str "elyth" "the name to use for the user account.";
    fullname = mkOpt str "Gwenc'hlan Le Kerneau" "the full name of the user";
    email = mkOpt str "gwen@omg.lol" "the email of the user";
    extraOptions = mkOpt attrs { } "extra options passed to <option>users.users.<name></option>.";
  };

  config = {
    users.users.${cfg.name} = {
      inherit (cfg) name;
      home = "/Users/${cfg.name}";
    }
    // cfg.extraOptions;

    system.primaryUser = cfg.name;
  };
}
