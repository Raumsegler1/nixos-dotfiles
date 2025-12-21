{config, pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;
    settings ={
      general = {
        disable_loading_bar = false;
      };

      background = {
        blur_passes = 2; # 0 disables blurring
        blur_size = 3;
        noise = 0.0117;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;

        #size = 9;
        #passes = 4;
        #vibrancy = 0.1696;
      };

      input-field = {
        size = "200, 50";
        outline_thickness = 3;
        #outer_color = $color11;
        #inner_color = "rgba(0, 0, 0, 0)";
        #font_color = $foreground;
      };

      label = {
        text = "$TIME";
        #color = $color5;
        font_size = 80;
        font_family = "CasakydiaCove Nerd Font Mono";
        position = "0, 140";
        halign = "center";
        valign = "center";
      };
    };
  }; 

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
    ];
    xwayland.enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [
        # Logout
        "$mod SHIFT, H, exec, hyprctl dispatch exit"
        # Window/Session actions
        "$mod, Q, killactive"
        "ALT, return, fullscreen"
        "$mod, W, togglefloating"
        "$mod, L, exec, hyprlock"

        # Application shortcuts
        "$mod, T, exec, kitty"
        "$mod SHIFT, T, exec, [float] kitty"
	      "$mod, C, exec, chromium"
        "$mod, E, exec, dolphin"

        # Move focus with ALT + WASD
        "ALT, A, movefocus, l"
        "ALT, D, movefocus, r"
        "ALT, W, movefocus, u"
        "ALT, S, movefocus, d"

        # Switch workspace with mod + [1-5]
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"

        # Move active window to workspace with mod + [1-5]
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"

        # Toggle Window Layout
        "$mod, J, togglesplit" #dwindle

        # Scratchpad
        "$mod, S, togglespecialworkspace"
        "$mod SHIFT, S, movetoworkspacesilent"
      ];

      bindm = [
        # Move/Resize windows with mainMod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      exec-once = [
        "systemctl --user start hyprpolkitagent.service"
        "waybar"
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
        #force_default_wallpaper = 0;
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

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };

      #env = [
        #"LIBVA_DRIVER_NAME, nvidia"
        #"__GLX_VENDOR_LIBRARY_NAME, nvidia"
        #"NVD_BACKEND, direct" # needs libva-nvidia-driver
        #"WLR_DRM_DEVICES,/dev/dri/card0 # Only use iGPU" # needs working amd-gpu

     #   "XDG_CURRENT_DESKTOP,Hyprland"
     #   "XDG_SESSION_TYPE,wayland"
     #   "XDG_SESSION_DESKTOP,Hyprland"

     #   "MOZ_ENABLE_WAYLAND,1"
     #   "WLR_NO_HARDWARE_CURSORS,1"
      #];

      cursor = {
        no_hardware_cursors =  1;
        enable_hyprcursor = true;
      };
      env = [ 
        "WLR_RENDERER_ALLOW_SOFTWARE,1"
        "WLR_NO_HARDWARE_CURSORS,1"
        "AQ_DRM_DEVICES,/dev/dri/card0:/dev/dri/card1"
        "HYPRCURSOR_THEME,Bibata-Modern-Ice"
        "HYPRCURSOR_SIZE,18"

        "QT_QPA_PLATFORM,wayland"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      ];

      monitor = [
        "WAYLAND-1,2560x1600@165Hz,auto,1"
        #"WAYLAND-1,1280x800@165Hz,auto,1"

      ];
      debug = {
        overlay = false;
        disable_logs = false;
        disable_time = false;
        enable_stdout_logs = true;
      };
    };
  };
}
