{ ... }:
{
  flake.modules.homeManager.tokyonight-moon = {
    programs.ghostty.settings.theme = "TokyoNight Moon";

    programs.opencode.settings.theme = "tokyonight";

    home.file.".config/sketchybar/theme.lua".text = ''
      return {
        crust = 0xff1a1b26,
        mantle = 0xff414868,
        base = 0xff24283b,
        text = 0xffc0caf5,
        muted = 0xff9aa5ce,
        red = 0xfff7768e,
        orange = 0xffff9e64,
        yellow = 0xffe0af68,
        green = 0xff9ece6a,
        cyan = 0xff2ac3de,
        blue = 0xff7aa2f7,
        purple = 0xffbb9af7,
      }
    '';
  };
}
