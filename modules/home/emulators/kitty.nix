{ ... }:
{
  flake.modules.homeManager.kitty = {
    programs.kitty = {
      enable = true;
      settings = {
        enable_audio_bell = false;
        close_on_child_death = true;
        cursor_blink_interval = 0;

        enabled_layouts = "fat, tall, vertical";
        wayland_titlebar_color = "background";

        allow_remote_control = true;
        listen_on = "unix:/tmp/kitty";
        dynamic_background_opacity = true;

        window_padding_width = 15;
        tab_bar_margin_width = 15;

        notify_on_cmd_finish = "unfocused";

        scrollback_pager = "less --chop-long-lines --raw-control-chars +INPUT_LINE_NUMBER";

        background_opacity = 0.85;
        background = "#151b2f";
        background_blur = 64;
        hide_window_decorations = "yes";

        font_family = "JetBrainsMono Nerd Font Mono";
        font_size = 13.0;

        cursor_trail = 1;
      };

      shellIntegration.enableFishIntegration = true;
    };
  };
}
