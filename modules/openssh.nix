{
  flake.modules.nixos.openssh = {
    services.openssh = {
      enable = true;
      settings = {
        # disable usage of password authentication
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        LogLevel = "VERBOSE";
      };
    };
  };
}
