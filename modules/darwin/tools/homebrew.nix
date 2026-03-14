{ ... }:
{
  flake.modules.darwin.homebrew =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.mas ];

      homebrew = {
        enable = true;
        caskArgs.no_quarantine = true;
        global = {
          brewfile = true;
          autoUpdate = true;
        };
        onActivation = {
          autoUpdate = true;
          cleanup = "uninstall";
          upgrade = true;
        };
      };
    };
}
