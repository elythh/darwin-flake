{ ... }:
{
  flake.modules.darwin.input = {
    security.pam.services.sudo_local.touchIdAuth = true;

    system = {
      keyboard.enableKeyMapping = true;
      keyboard.remapCapsLockToEscape = true;

      defaults = {
        trackpad = {
          ActuationStrength = 0;
          Clicking = true;
          FirstClickThreshold = 1;
          SecondClickThreshold = 1;
          TrackpadRightClick = true;
          TrackpadThreeFingerDrag = true;
        };

        ".GlobalPreferences"."com.apple.mouse.scaling" = 1.0;
      };
    };
  };
}
