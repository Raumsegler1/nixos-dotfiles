{ config, pkgs, ... }:

{
  # Matugen config for waybar
  # This tells Matugen how to write the CSS file
  xdg.configFile."matugen/templates/waybar.css".text = ''
    /* * Css Colors - Generated with Matugen
     */
    <* for name, value in colors *>
    @define-color {{name}} {{value.default.hex}};
    <* endfor *>
  '';

  # 2. THE CONFIG (The Instruction)
  # This tells Matugen where to find the template and where to save the result
  xdg.configFile."matugen/config.toml".text = ''
    [config]
    # General settings here if needed

    [templates.waybar]
    input_path = "${config.home.homeDirectory}/.config/matugen/templates/waybar.css"
    output_path = "${config.home.homeDirectory}/.config/waybar/colors.css"
    post_hook = "pkill -SIGUSR2 waybar"
  '';

  programs.waybar = {
    enable = true;

programs.waybar.style = ''
  /* Import Matugen colors */
  @import "${config.home.homeDirectory}/.config/waybar/colors.css";

  * {
    border: none;
    border-radius: 0;
    min-height: 0;
    font-family: "JetBrainsMono Nerd Font";
    font-size: 13px;
  }

  window#waybar {
    background-color: @rgba; /* Ensure @rgba is defined in your colors.css */
    transition-property: background-color;
    transition-duration: 0s;
    border: 0px solid @bg_color7;
    border-radius: 8px;
  }

  window#waybar.hidden {
    background-color: transparent;
  }

  /* Combined module containers */
  .modules-left,
  .modules-right,
  .modules-center {
    background-color: transparent;
    border-radius: 4px;
    padding: 2px 4px;
    margin: 2px;
  }

  #workspaces {
    background-color: transparent;
  }

  #workspaces button {
    all: initial; /* Remove GTK theme values */
    min-width: 0;
    box-shadow: inset 0 -3px transparent; /* Fix spacing in materia */
    padding: 4px 15px 4px 14px;
    margin: 4px;
    border-radius: 4px;
    background-color: @bg_workspace;
    color: @fg_workspace;
  }

  #workspaces button.active {
    color: @bg_workspace;
    background-color: @fg_workspace;
  }

  #workspaces button:hover {
    box-shadow: inherit;
    text-shadow: inherit;
    color: @bg_workspace;
    background-color: @fg_workspace;
  }

  #workspaces button.urgent {
    background-color: @bg_color2;
  }

  /* Common styles for right-side modules */
  #memory,
  #custom-power,
  #battery,
  #backlight,
  #wireplumber,
  #custom-pipewire,
  #network,
  #clock,
  #tray {
    border-radius: 4px;
    margin: 6px 3px;
    padding: 6px 12px;
    background-color: @bg_workspace;
    color: @bg_main;
  }

  #custom-logo {
    padding-right: 7px;
    padding-left: 11px;
    font-size: 15px;
    border-radius: 4px;
    margin: 4px 18px 4px 4px;
    background-color: @bg_color1;
    color: @bg_main;
  }

  #memory {
    background-color: @bg_color3;
  }

  #battery {
    background-color: @bg_color2;
  }

  #battery.warning,
  #battery.critical,
  #battery.urgent {
    background-color: @bg_warn;
    color: @fg_warn;
  }

  #battery.charging {
    background-color: @bg_color3;
    color: @bg_main;
  }

  #backlight {
    background-color: @bg_color4;
  }

  #wireplumber,
  #custom-pipewire {
    background-color: @bg_color5;
  }

  #network {
    background-color: @bg_color6;
    padding-right: 17px;
  }

  #clock {
    font-family: "JetBrainsMono Nerd Font";
    background-color: @bg_color7;
  }

  #custom-power {
    margin-right: 6px;
    background-color: @bg_color8;
  }

  /* Tooltips */
  tooltip {
    border-radius: 8px;
    padding: 15px;
    background-color: @bg_color3;
    color: @bg_main;
    text-shadow: none;
    border-color: transparent;
  }

  tooltip label {
    padding: 5px;
    background-color: @bg_color3;
    color: @bg_main;
    text-shadow: none;
  }

  tooltip * {
    text-shadow: none;
    border-color: transparent;
    border-width: 0px;
  }
'';
    
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin-top = 10;
        margin-left = 10;
        margin-right = 10;
        margin-bottom = 0;
        spacing = 0;

        modules-left = [
          "custom/logo"
          "hyprland/workspaces"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "tray"
          "memory"
          "network"
          "custom/pipewire"
          "custom/power"
        ];

        "wlr/taskbar" = {
          format = "{icon}";
          on-click = "activate";
          on-click-right = "fullscreen";
          icon-theme = "";
          icon-size = 25;
          tooltip-format = "{title}";
        };

        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            default = "";
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            active = "󱓻";
            urgent = "󱓻";
          };
          persistent_workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
        };

        memory = {
          interval = 5;
          format = "󰍛 {}%";
          max-length = 10;
        };

        tray = {
          spacing = 10;
        };

        clock = {
          tooltip-format = "{calendar}";
          format = "  {:%H:%M}";
          on-click = "ags -t calendarmenu";
        };

        network = {
          format-wifi = "{icon}";
          format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          format-ethernet = "󰀂";
          format-alt = "󱛇";
          format-disconnected = "󰖪";
          tooltip-format-wifi = "{icon} {essid}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-ethernet = "󰀂  {ifname}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-disconnected = "Disconnected";
          on-click = "ags -t networkmenu";
          on-click-right = "";
          interval = 5;
          nospacing = 1;
        };

        wireplumber = {
          format = "{icon}";
          format-bluetooth = "󰂰";
          nospacing = 1;
          tooltip-format = "Volume : {volume}%";
          format-muted = "󰝟";
          format-icons = {
            headphone = "";
            default = [ "󰖀" "󰕾" "" ];
          };
          on-click = "ags -t audiomenu";
          scroll-step = 1;
        };

        "custom/logo" = {
          format = " ";
          tooltip = false;
          on-click = "ags -t dashboardmenu";
        };

        battery = {
          format = "{capacity}% {icon}";
          format-icons = {
            charging = [
              "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" 
              "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"
            ];
            default = [
              "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" 
              "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"
            ];
          };
          format-full = "Charged ";
          interval = 5;
          states = {
            warning = 20;
            critical = 10;
          };
          tooltip = false;
        };

        "custom/power" = {
          format = "󰤆";
          tooltip = false;
          on-click = "ags -t powerdropdownmenu";
        };

        "custom/pipewire" = {
          exec = "pw-volume status";
          return-type = "json";
          interval = "once";
          signal = 8;
          on-click = "ags -t audiomenu";
          format = "{icon} {percentage}%";
          format-icons = {
            mute = "";
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
        };
      };
    };
  };
}
