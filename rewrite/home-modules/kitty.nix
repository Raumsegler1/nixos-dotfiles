{ config, pkgs, ... }:

{
  programs.kitty = {
      enable = true;
      font = {
        package = pkgs.nerd-fonts.iosevka; #for 25.11
        #package = pkgs.nerdfonts;
        name = "Iosevka Nerd Font";
        size = 12;
      };

      shellIntegration.enableFishIntegration = true;

      extraConfig = ''
        include ${config.home.homeDirectory}/.config/kitty/colors.conf
      '';
      
      settings = {
        shell = "${pkgs.fish}/bin/fish";
      
        window_margin_width = 0;
        window_padding_width = 4;
        confirm_os_windows_close = 0;

        background_opacity = 1;
        sync_to_monitor = true;
        tab_bar_edge = "bottom";
        tab_bar_style = "fade";

        cursor_shape = "beam";
        cursor_beam_thickness = "4.5";
        curso_blink_interval = 0;

        detect_urls = true;
        url_color = "#0087bd";
        url_style = "curly";

        enable_audio_bell = false;

        scrollback_lines = 1500;
        wheel_scroll_multiplier = "10.0";
      };
  };
  # Matugen config for kitty
  # This tells Matugen how to write the conf file
  xdg.configFile."matugen/templates/kitty-colors.conf".text = ''
cursor {{colors.on_surface.default.hex}}
cursor_text_color {{colors.on_surface_variant.default.hex}}

foreground            {{colors.on_surface.default.hex}}
background            {{colors.surface.default.hex}}
selection_foreground  {{colors.on_secondary.default.hex}}
selection_background  {{colors.secondary_fixed_dim.default.hex}}
url_color             {{colors.primary.default.hex}}

# black
color8   #262626
color0   #4c4c4c

# red
color1   #ac8a8c
color9   #c49ea0

# green
color2   #8aac8b
color10  #9ec49f

# yellow
color3   #aca98a
color11  #c4c19e

# blue
/* color4  #8f8aac */
color4  {{colors.primary.default.hex}}
color12 #a39ec4

# magenta
color5   #ac8aac
color13  #c49ec4

# cyan
color6   #8aacab
color14  #9ec3c4

# white
color15   #e7e7e7
color7  #f0f0f0
  '';

  # 2. THE CONFIG (The Instruction)
  # This tells Matugen where to find the template and where to save the result
  xdg.configFile."matugen/config.toml".text = ''
    [templates.kitty]
    input_path = '${config.home.homeDirectory}/.config/matugen/templates/kitty-colors.conf'
    output_path = '${config.home.homeDirectory}/.config/kitty/colors.conf'
    post_hook = 'pkill -SIGUSR1 kitty'
  '';
}