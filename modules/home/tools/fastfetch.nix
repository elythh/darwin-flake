{ ... }:
{
  flake.modules.homeManager.fastfetch = {
    programs.fastfetch = {
      enable = true;
      settings = {
        modules = [
          "os"
          "host"
          "uptime"
          "packages"
          "shell"
          "terminal"
          "terminalfont"
          "cpu"
          "gpu"
          "colors"
        ];
      };
    };
  };
}
