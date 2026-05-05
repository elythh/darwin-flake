{ inputs, ... }:
{
  flake.modules.homeManager.ghostty =
    { pkgs, ... }:
    let
      cursorWarpPatch = builtins.toFile "ghostty-cursor-warp.patch" ''
        diff --git a/cursor_warp.glsl b/cursor_warp.glsl
        index 02ea35f..7d06468 100644
        --- a/cursor_warp.glsl
        +++ b/cursor_warp.glsl
        @@ -1,13 +1,13 @@
         // --- CONFIGURATION ---
        -vec4 TRAIL_COLOR = iCurrentCursorColor; // can change to eg: vec4(0.2, 0.6, 1.0, 0.5);
        -const float DURATION = 0.2; // total animation time
        -const float TRAIL_SIZE = 0.8; // 0.0 = all corners move together. 1.0 = max smear (leading corners jump instantly)
        +vec4 TRAIL_COLOR = iCurrentCursorColor; // follow cursor color; avoids forced neon tint
        +const float DURATION = 0.45; // total animation time
        +const float TRAIL_SIZE = 1.0; // 0.0 = all corners move together. 1.0 = max smear (leading corners jump instantly)
         const float THRESHOLD_MIN_DISTANCE = 1.5; // min distance to show trail (units of cursor height)
        -const float BLUR = 1.0; // blur size in pixels (for antialiasing)
        -const float TRAIL_THICKNESS = 1.0;  // 1.0 = full cursor height, 0.0 = zero height, >1.0 = funky aah
        -const float TRAIL_THICKNESS_X = 0.9;
        +const float BLUR = 2.5; // blur size in pixels (for antialiasing)
        +const float TRAIL_THICKNESS = 1.35;  // 1.0 = full cursor height, 0.0 = zero height, >1.0 = funky aah
        +const float TRAIL_THICKNESS_X = 1.35;
         
        -const float FADE_ENABLED = 0.0; // 1.0 to enable fade gradient along the trail, 0.0 to disable
        -const float FADE_EXPONENT = 5.0; // exponent for fade gradient along the trail
        +const float FADE_ENABLED = 1.0; // 1.0 to enable fade gradient along the trail, 0.0 to disable
        +const float FADE_EXPONENT = 2.5; // exponent for fade gradient along the trail
      '';
      rippleCursorPatch = builtins.toFile "ghostty-ripple-cursor.patch" ''
        diff --git a/ripple_cursor.glsl b/ripple_cursor.glsl
        index 8be2f91..f903b4a 100644
        --- a/ripple_cursor.glsl
        +++ b/ripple_cursor.glsl
        @@ -1,10 +1,10 @@
         // CONFIGURATION
        -const float DURATION = 0.15;               // How long the ripple animates (seconds)
        -const float MAX_RADIUS = 0.05;             // Max radius in normalized coords (0.5 = 1/4 screen height)
        -const float RING_THICKNESS = 0.02;             // Ring width in normalized coords
        +const float DURATION = 0.2;                // How long the ripple animates (seconds)
        +const float MAX_RADIUS = 0.04;             // Keep ripple compact
        +const float RING_THICKNESS = 0.018;        // Keep ring visually tight
         const float CURSOR_WIDTH_CHANGE_THRESHOLD = 0.5; // Triggers ripple if cursor width changes by this fraction
        -vec4 COLOR = vec4(0.35, 0.36, 0.44, 1.0); // change to iCurrentCursorColor for your cursor's color
        -const float BLUR = 3.0;                    // Blur level in pixels
        -const float ANIMATION_START_OFFSET = 0.0;        // Start the ripple slightly progressed (0.0 - 1.0)
        +vec4 COLOR = iCurrentCursorColor;          // follow cursor color; avoids fixed tint
        +const float BLUR = 2.5;                    // Crisper/smaller visual footprint
        +const float ANIMATION_START_OFFSET = 0.0;  // Start from true origin
      '';

      patchedGhosttyShaders = pkgs.applyPatches {

        name = "ghostty-cursor-shaders-patched";
        src = inputs.ghostty-cursor-shaders;
        patches = [
          cursorWarpPatch
          rippleCursorPatch
        ];
      };
    in
    {
      xdg.configFile."ghostty/shaders".source = patchedGhosttyShaders;

      programs.ghostty = {
        enable = true;
        package = null;
        enableZshIntegration = true;

        settings = {
          shell-integration = "fish";
          shell-integration-features = "no-cursor";
          background-opacity = 0.85;
          background-blur = 255;
          font-size = 13;
          font-family = "JetBrainsMono Nerd Font Mono";
          font-thicken = true;
          cursor-style = "block";
          custom-shader = [
            "shaders/cursor_warp.glsl"
            "shaders/ripple_cursor.glsl"
          ];
          custom-shader-animation = "always";
          mouse-hide-while-typing = true;
          window-colorspace = "display-p3";
          adjust-cell-height = "30%";
          macos-titlebar-style = "hidden";
          macos-option-as-alt = "left";
          window-inherit-working-directory = false;
          window-padding-balance = true;
          window-padding-x = 15;
          window-padding-y = 15;
          quick-terminal-position = "right";
        };
      };
    };
}
