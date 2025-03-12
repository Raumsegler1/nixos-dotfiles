{config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    #package = null;
    #portalPackage = null;
    xwayland.enable = true;
    /*extraConfig = ''
      ${builtins.readFile ./hypr/hyprland.conf}
      ${builtins.readFile ./hypr/animations.conf}
      ${builtins.readFile ./hypr/rules.conf}
      ${builtins.readFile ./hypr/theme.conf}
      ${builtins.readFile ./hypr/keybindings.conf}
    ''; */
    settings = {
      "$mod" = "SUPER";
      bind = [
	      "$mod, T, exec, kitty"
	      "$mod, C, exec, chromium"
      ];

      decoration = {
        rounding = 10;
        #drop_shadow = false
        #shadow_range = 1
        active_opacity = 0.93;
        inactive_opacity = 0.93;
        dim_inactive = true;
        dim_strength = 0.18;
        dim_special = 0.5;
        blur = {
          enabled = "yes"; 
          size = 5;
          passes = 3;
          noise = 0;
          brightness = 0.90;
          special = true;
        };
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 3;
        layout = "dwindle";
        #layout = scroller;
        resize_on_border = true;
      };

      dwindle = {
        pseudotile = "no"; 
        preserve_split = "yes"; 
        # special_scale_factor = 0.9;
      };

      animations = {
        enabled = "yes";

        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.76, 0.42, 0.74, 0.87"
          "winOut, 0.76, 0.42, 0.74, 0.87"
          "workIn, 0.72, -0.07, 0.41, 0.98"
          "linear, 1, 1, 1, 1"
        ];

        animation = [
          "windows, 1, 6, wind, popin"
          "windowsIn, 1, 1, workIn, popin"
          "windowsOut, 1, 5, workIn, popin"
          "windowsMove, 1, 5, wind, slide"

          "fadeIn, 1, 2, winIn"
          "fadeOut, 1, 5, winOut"

          "workspaces, 1, 3, workIn, slide"
          "specialWorkspace, 1, 5, workIn, slidevert"
        ];
      };

      misc = {
        force_default_wallpaper = 0;
      };

      input = {
        kb_layout = "de";
        repeat_rate = 50;
        repeat_delay = 300;

        follow_mouse = 1;
        touchpad = {
          natural_scroll = "yes"; 
        };

        #sensitivity = -0.3; # -1.0 - 1.0, 0 means no modification.
        accel_profile = "flat";
      };

      env = [
        #"LIBVA_DRIVER_NAME, nvidia"
        #"__GLX_VENDOR_LIBRARY_NAME, nvidia"
        #"NVD_BACKEND, direct" # needs libva-nvidia-driver
        "WLR_DRM_DEVICES,/dev/dri/card0 # Only use iGPU" # needs working amd-gpu


        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"

        "QT_QPA_PLATFORM,wayland"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"

        "MOZ_ENABLE_WAYLAND,1"
        "WLR_NO_HARDWARE_CURSORS,1"
      ];

      monitor = [
        ",preffered,auto,1"
        "VGA-1,disable"
      ];
    };
  };
}
