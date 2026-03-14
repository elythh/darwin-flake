{ config, ... }:
let
  username = config.flake.meta.users.default.username;
in
{
  flake.modules.darwin.interface = {
    system.defaults = {
      CustomSystemPreferences.finder = {
        DisableAllAnimations = true;
        FXEnableExtensionChangeWarning = false;
        QuitMenuItem = true;
        ShowExternalHardDrivesOnDesktop = false;
        ShowHardDrivesOnDesktop = false;
        ShowMountedServersOnDesktop = false;
        ShowPathbar = true;
        ShowRemovableMediaOnDesktop = false;
        _FXSortFoldersFirst = true;
      };

      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.45;
        orientation = "bottom";
        show-recents = false;
        persistent-apps = [
          "/Applications/Ghostty.app/"
          "/System/Applications/Music.app/"
        ];
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        CreateDesktop = true;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "Nlsv";
        QuitMenuItem = true;
        ShowStatusBar = false;
        _FXShowPosixPathInTitle = true;
      };

      loginwindow.GuestEnabled = false;

      screencapture = {
        disable-shadow = true;
        location = "/Users/${username}/Pictures/screenshots/";
        type = "png";
      };

      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleShowAllExtensions = true;
        AppleShowScrollBars = "Automatic";
        NSAutomaticWindowAnimationsEnabled = false;
        _HIHideMenuBar = false;
      };

      CustomUserPreferences."com.apple.SoftwareUpdate" = {
        AutomaticCheckEnabled = true;
        AutomaticDownload = 1;
        CriticalUpdateInstall = 1;
        ScheduleFrequency = 1;
      };
    };
  };
}
