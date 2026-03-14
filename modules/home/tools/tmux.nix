{ ... }:
{
  flake.modules.homeManager.tmux =
    { pkgs, ... }:
    {
      programs.tmux = {
        enable = true;

        aggressiveResize = true;
        baseIndex = 1;
        disableConfirmationPrompt = true;
        keyMode = "vi";
        newSession = true;
        secureSocket = true;
        shell = "${pkgs.fish}/bin/fish";

        prefix = "C-space";
        shortcut = "Space";
        terminal = "screen-256color";

        plugins = with pkgs.tmuxPlugins; [
          catppuccin
          yank
          resurrect
          sensible
          vim-tmux-navigator
          tmux-sessionx
          continuum
          fzf-tmux-url
        ];

        extraConfig = ''
          set -g base-index 1
          set -g detach-on-destroy off
          set -g escape-time 0
          set -g history-limit 1000000
          set -g renumber-windows on
          set -g set-clipboard on
          setw -g mode-keys vi

          set -g @fzf-url-fzf-options '-p 60%,30% --prompt="   " --border-label=" Open URL "'
          set -g @fzf-url-history-limit '2000'

          set -g @sessionx-bind-zo-new-window 'ctrl-y'
          set -g @sessionx-auto-accept 'off'
          set -g @sessionx-bind 'o'
          set -g @sessionx-x-path '/Users/elyth/Documents/'
          set -g @sessionx-window-height '85%'
          set -g @sessionx-window-width '75%'
          set -g @sessionx-zoxide-mode 'on'
          set -g @sessionx-custom-paths-subdirectories 'false'
          set -g @sessionx-filter-current 'false'

          set -g @continuum-restore 'on'
          set -g @resurrect-strategy-nvim 'session'

          set -g @catppuccin_flavor "mocha"
          set -g @catppuccin_window_status_style "rounded"

          set -g status-right-length 100
          set -g status-left-length 100
          set -g status-left ""
          set -g status-style "bg=default"
          set -g status-right "#{E:@catppuccin_status_application}"
          set -agF status-right "#{E:@catppuccin_status_cpu}"
          set -ag status-right "#{E:@catppuccin_status_session}"
          set -ag status-right "#{E:@catppuccin_status_uptime}"
          set -agF status-right "#{E:@catppuccin_status_battery}"
        '';
      };
    };
}
