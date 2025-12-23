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

    @define-color my_transparent_bg rgba({{colors.surface.default.red}}, {{colors.surface.default.green}}, {{colors.surface.default.blue}}, 0.9);
  '';

  # 2. THE CONFIG (The Instruction)
  # This tells Matugen where to find the template and where to save the result
  xdg.configFile."matugen/config.toml".text = ''
    [templates.waybar]
    input_path = "${config.home.homeDirectory}/.config/matugen/templates/waybar.css"
    output_path = "${config.home.homeDirectory}/.config/waybar/colors.css"
    post_hook = "pkill -SIGUSR2 waybar"
  '';

  programs.waybar = {
    enable = true;

    style = ''
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
    background-color: @my_transparent_bg;
    transition-property: background-color;
    transition-duration: 0s;
    border: 0px solid @primary_fixed;
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
    background-color: @on_primary_container;
    color: @surface;
  }

  #workspaces button.active {
    background-color: @primary;
    color: @surface;
  }

  #workspaces button.active:hover {
    background-color: @surface;
    color: @primary;
  }

  #workspaces button:hover {
    box-shadow: inherit;
    text-shadow: inherit;
    color: @on_primary_container;
    background-color: @surface;
  }

  #workspaces button.urgent {
    background-color: @on_primary_container;
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
    background-color: @on_primary_container;
    color: @surface;
  }

  #memory:hover,
  #custom-power:hover,
  #battery:hover,
  #backlight:hover,
  #wireplumber:hover,
  #custom-pipewire:hover,
  #network:hover,
  #clock:hover,
  #tray:hover {
    background-color: @surface;
    color: @on_primary_container;
  }

  #custom-logo {
    padding-right: 7px;
    padding-left: 11px;
    font-size: 15px;
    border-radius: 4px;
    margin: 4px 18px 4px 4px;
    background-color: @tertiary;
    color: @surface;
  }

  #battery.warning,
  #battery.critical,
  #battery.urgent {
    background-color: @error;
    color: @surface;
  }

  #battery.charging {
    background-color: @primary;
    color: @surface;
  }

  #backlight {
    background-color: @tertiary;
    color: @surface;
  }

  #backlight:hover {
    background-color: @surface;
    color: @tertiary;
  }

  #wireplumber,
  #custom-pipewire {
    background-color: @tertiary_fixed;
  }

  #network {
    background-color: @on_primary_container;
    color: @surface;
    padding-right: 17px;
  }

  #network:hover {
    background-color: @surface;
    color: @on_primary_container;
  }

  #clock {
    font-family: "JetBrainsMono Nerd Font";
    background-color: @tertiary_fixed;
    color: @surface;
  }

  #clock:hover {
    background-color: @surface;
    color: @tertiary_fixed;
  }

  #custom-power {
    margin-right: 6px;
    background-color: @tertiary;
  }

  #custom-power:hover {
    margin-right: 6px;
    background-color: @surface;
    color: @tertiary;
  }

  /* Tooltips */
  tooltip {
    border-radius: 8px;
    padding: 15px;
    background-color: @primary;
    color: @surface;
    text-shadow: none;
    border-color: transparent;
  }

  tooltip label {
    padding: 5px;
    background-color: @primary;
    color: @surface;
    text-shadow: none;
  }

  tooltip * {
    text-shadow: none;
    border-color: transparent;
    border-width: 0px;
  }''
    ;
    
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
          "battery"
          "tray"
          "memory"
          "network"
          "wireplumper"
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
          format = "  {:%H:%M}";
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
          format = " ";
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
          on-click = "hyprctl dispatch exit";
        };

        "custom/pipewire" = {
          exec = "wpctl get-volume @DEFAULT_AUDIO_SINK@";
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
