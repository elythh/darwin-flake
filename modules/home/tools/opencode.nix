{ ... }:
{
  flake.modules.homeManager.opencode = {
    programs.opencode = {
      enable = true;
      settings = {
        model = "groq/openai/gpt-oss-120b";
      };
    };
  };
}
