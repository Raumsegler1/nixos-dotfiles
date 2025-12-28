{config, pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;
    settings ={
      general = {
        disable_loading_bar = false;
      };
      "source" = "colors.conf";

      background = {
        path = "$image";
        blur_passes = 2; # 0 disables blurring
        blur_size = 3;
        noise = 0.0117;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
        size = 9;
        passes = 4;
      };

      input-field = {
        size = "200, 50";
        outline_thickness = 3;
        outer_color = "$outline";
        inner_color = "$surface";
        font_color = "$primary";
      };

      label = {
        text = "$TIME";
        color = "$tertiary";
        font_size = 80;
        font_family = "CasakydiaCove Nerd Font Mono";
        position = "0, 140";
        halign = "center";
        valign = "center";
      };
    };
  };

  services = {
    hyprpolkitagent.enable = true;
    hyprsunset = {
      enable = true;
      settings = {
        #look in homemanager wiki
      };
    };
    hypridle = {
      enable = true;
      settings = {
        /*general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };

        listener = [
          {
            timeout = 900;
            on-timeout = "hyprlock";
          }
          {
            timeout = 1200;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];*/
      };
    };
  };

  home.packages = with pkgs; [
    # Hyprland utilities
    hyprsysteminfo  # systeminfo gui 
    hyprpwcenter    # audio/pipewire gui
    hyprtoolkit     # customization for other utilities
    hyprshot        # screenshot tool
    hyprpicker      # color picker
    #hyprshutdown is in configuration.nix
  ];

  wayland.windowManager.hyprland = {
    systemd.enable = false;
    enable = true;
    plugins = with pkgs.hyprlandPlugins; [
      hyprspace
    ];
    xwayland.enable = true;
    settings = {
      "source" = "colors.conf";
      "$mod" = "SUPER";

      "xwayland:force_zero_scaling" = true; #fix for onlyoffice
      bind = [
        # Logout
        "$mod SHIFT, H, exec, hyprshutdown"

        # Touchpad toggle
        '',XF86TouchpadToggle, exec, sh -c 'if [ -f /tmp/tp_off ]; then hyprctl keyword "device[asup1208:00-093a:3011-touchpad]:enabled" true && rm /tmp/tp_off && dunstify -r 4 "Touchpad" "Enabled"; else hyprctl keyword "device[asup1208:00-093a:3011-touchpad]:enabled" false && touch /tmp/tp_off && dunstify -r 4 "Touchpad" "Disabled"; fi' ''       
        
        # Screenshots using Hyprshot
        "$mod, ALT, exec, hyprshot -m window"      # screenshot window
        "$mod SHIFT, P, exec, hyprshot -m output"  # screenshot monitor
        "$mod, P, exec, hyprshot -m region"        # screenshot region  # fn + f9 also does mod + p

        # Window/Session actions
        "$mod, Q, killactive"
        "ALT, return, fullscreen"
        "$mod, F, togglefloating"
        "$mod, L, exec, hyprlock"

        # Application shortcuts
        #",XF86Launch4, exec,"  # ASUS Aura Button 
        ",XF86Launch3, exec, hyprctl dispatch dpms toggle" # ASUS Armoury (Key next to mic mute) // Turns off/on screen
        #",XF86Assist, exec, wofi --show drun" #copilot button
        "$mod, T, exec, kitty"
        "$mod SHIFT, T, exec, [float] kitty"
	      "$mod, C, exec, chromium"
        "$mod, W, exec, wallpaper-picker"
        "$mod, R, exec, rofi -config ~/.config/rofi/launcher.rasi -show drun"
        "$mod, D, exec, dolphin"
        "$mod, V, exec, codium"

        # Move focus with ALT + WASD
        "ALT, A, movefocus, l"
        "ALT, D, movefocus, r"
        "ALT, W, movefocus, u"
        "ALT, S, movefocus, d"

        # Toggle Window Layout
        "$mod, J, togglesplit" #dwindle

        # Scratchpad
        "$mod, S, togglespecialworkspace"
        "$mod SHIFT, S, movetoworkspacesilent"
      ]
      ++ (
      # Create lists for workspaces 1-9
        builtins.concatLists (builtins.genList (
           x: let
              ws = toString (x + 1);
           in [
              "$mod, ${ws}, workspace, ${ws}"                # Switch workspace with mod + [1-5]
              "$mod SHIFT, ${ws}, movetoworkspace, ${ws}"    # Move active window to workspace with mod + [1-5]
            ]
        ) 9)
      );

      binde = [
        # --- Volume (wpctl)(dunstify ID 1) ---
        '', XF86AudioRaiseVolume, exec, wpctl set-volume -l 2.0 @DEFAULT_AUDIO_SINK@ 5%+ && sh -c 'vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk "{print int(\$2 * 100)}"); dunstify "Volume: ''${vol}%" -h int:value:$vol -r 1 -t 1000 -a "Audio" -u low' ''
        '', XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && sh -c 'vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk "{print int(\$2 * 100)}"); dunstify "Volume: ''${vol}%" -h int:value:$vol -r 1 -t 1000 -a "Audio" -u low' ''

        # --- Brightness (brightnessctl)(dunstify ID 2) ---
        '', XF86MonBrightnessUp, exec, brightnessctl set 5%+ && sh -c 'val=$(brightnessctl -m | cut -d, -f4 | tr -d %); dunstify "''${val}%" -h int:value:$val -r 2 -t 1000 -a "Brightness  " -u low' ''
        '', XF86MonBrightnessDown, exec, brightnessctl set 5%- && sh -c 'val=$(brightnessctl -m | cut -d, -f4 | tr -d %); dunstify "''${val}%" -h int:value:$val -r 2 -t 1000 -a "Brightness  " -u low' ''
      ];

      bindl = [
        # --- Mute (wpctl)(dunstify: audio ID 1; mic ID 3) ---
        '',XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && dunstify -a "Audio" -u low -r 1 -t 1000 "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo 'Muted  ' || wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print "Unmuted  : " int($2 * 100) "%"}')"''
        '',XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && dunstify -a "Audio" -u low -r 3 -t 1000 "Microphone" "$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED && echo 'Muted  ' || echo 'Unmuted  ')"''
  ];

      bindm = [
        # Move/Resize windows with mainMod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      exec-once = [
        #"systemctl --user start hyprpolkitagent.service"
        "uwsm app -- waybar"
        "uwsm app -- awww-daemon"
        "wl-paste --watch cliphist store"
        "uwsm app -- dunst"
        "XDG_MENU_PREFIX=plasma- kbuildsycoca6"
        "uwsm app -- dunst"
      ];

      # Layer Rules
      layerrule = [
        "blur,logout"
        "blur, waybar"
        "ignorezero, waybar"
        "blur, rofi"
      ];

      windowrule = [
      # Syntax: EFFECT, CONDITIONS
      # 1. Hide borders for tiled kitty (class:kitty AND floating:0)
        "bordersize 0, floating:0, class:^(kitty)$"
      # 2. Hide borders if only 1 window (using workspace selector)
        "bordersize 0, floating:0, onworkspace:w[t1]"
      # 3. Rofi fixes
        "rounding 0, class:^(Rofi)$"
        "bordersize 0, class:^(Rofi)$"
      # 4. Disable transparency/blur for browsers
        "opaque, class:^(librewolf)$"
        "noblur, class:^(librewolf)$"
        "opaque, class:^(chromium-browser)$"
        "noblur, class:^(chromium-browser)$"
      # 5. Dolphin starts floating
        "float, class:^(org.kde.dolphin)$"
      ];

      # Workspace Rules
      workspace = "special,gapsin:24,gapsout:64";

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
        "col.active_border" = "$tertiary"; 
        "col.inactive_border" = "$primary";
        border_size = 3;
        layout = "dwindle";
        #layout = scroller;
        resize_on_border = true;
        snap = {
          enabled = true;
          respect_gaps = true;
        };
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
          clickfinger_behavior = true;
        };

        #sensitivity = -0.3; # -1.0 - 1.0, 0 means no modification.
        accel_profile = "adaptive";
      };

      "gesture" = [
        "3, horizontal, workspace"
        #"3, up, dispatcher, app"
      ];

      gestures = {
        workspace_swipe_forever = true;
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
        "HYPRSHOT_DIR,/home/raumsegler/Pictures/Screenshots"
        "WLR_RENDERER_ALLOW_SOFTWARE,1"
        "WLR_NO_HARDWARE_CURSORS,1"
        "AQ_DRM_DEVICES,/dev/dri/card0:/dev/dri/card1"
        "HYPRCURSOR_THEME,Bibata-Modern-Ice"
        "XCURSOR_THEME,Bibata-Modern-Ice"
        "HYPRCURSOR_SIZE,18"
        "XCURSOR_SIZE,18"                     

        "QT_QPA_PLATFORM,wayland"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"

        "XDG_MENU_PREFIX,plasma-"
      ];

      monitor = [
        "WAYLAND-1,2560x1600@165Hz,auto,1"
      ];
      debug = {
        overlay = false;
        disable_logs = false;
        disable_time = false;
        enable_stdout_logs = true;
      };
    };
  };
  # Matugen config for hyprland
  # This tells Matugen how to write the conf file
  xdg.configFile."matugen/templates/hyprland-colors.conf".text = ''
    $image = {{image}}
    <* for name, value in colors *>
    ''${{name}} = rgba({{value.default.hex_stripped}}ff)
    <* endfor *>
    '';

  # 2. THE CONFIG (The Instruction)
  # This tells Matugen where to find the template and where to save the result
  xdg.configFile."matugen/config.toml".text = ''
    [templates.hyprland]
    input_path = '${config.home.homeDirectory}/.config/matugen/templates/hyprland-colors.conf'
    output_path = '${config.home.homeDirectory}/.config/hypr/colors.conf'
    post_hook = 'hyprctl reload'
  '';

}
