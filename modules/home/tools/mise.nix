{ ... }:
{
  flake.modules.homeManager.mise = {
    programs.mise = {
      enable = true;
      enableFishIntegration = true;
      globalConfig = {
        tools = {
          node = "latest";
          python = [
            "3.10"
            "3.11"
          ];
          ruby = "latest";
          rust = "latest";
          rust-analyzer = "latest";
          go = "latest";
        };
        settings = {
          idiomatic_version_file_enable_tools = [ ];
        };
      };
    };
  };
}
