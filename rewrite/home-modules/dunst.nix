{ config, pkgs, ... }:

{
  home.packages = [ pkgs.dunst ];

  # Matugen config for dunst
  # This tells Matugen how to write the dunst-colors file
  xdg.configFile."matugen/templates/dunstrc-colors".text = ''
    [urgency_critical]
      background  = "{{colors.surface.default.hex}}"
      foreground  = "{{colors.error.default.hex}}"
      highlight   = "{{colors.error.default.hex}}"
      frame_color = "{{colors.error.default.hex}}"

    [urgency_low]
      background  = "{{colors.surface.default.hex}}"
      foreground  = "{{colors.secondary.default.hex}}"
      highlight   = "{{colors.secondary_container.default.hex}}"
      frame_color = "{{colors.surface.default.hex}}"

    [urgency_normal]
      background  = "{{colors.surface.default.hex}}"
      foreground  = "{{colors.primary.default.hex}}"
      highlight   = "{{colors.primary_container.default.hex}}"
      frame_color = "{{colors.tertiary.default.hex}}"
  '';

  # 2. THE CONFIG (The Instruction)
  # This tells Matugen where to find the template and where to save the result
  xdg.configFile."matugen/config.toml".text = ''
    [templates.dunst]
    input_path = '${config.home.homeDirectory}/.config/matugen/templates/dunstrc-colors'
    output_path = '${config.home.homeDirectory}/.config/dunst/dunstrc.d/colors.conf'
    post_hook = 'dunstctl reload'
  '';

  # Dunst Config  
  xdg.configFile."dunst/dunstrc".text = ''
    [global]
      monitor            = 0        # default: 0
      follow             = none     # default: none 
      ignore_dbusclose   = true     # default: false
      notification_limit = 10       # default: 20
      indicate_hidden    = true     # default: true
      idle_threshold     = 2m       # default: 0
      show_age_threshold = 5m       # default: 60
      show_indicators    = true     # values: [true/false], default: true
      markup             = full     # values: [full/strip/no], default: no

      width  = (250, 500)           # width between 150 and 500
      height = (50, 150)            # height between 50 and 150
      origin = top-right            # default: top-right
      offset = (8, 8)               # format: (horizontal, vertical), default: (10, 50)
      layer  = overlay              # default: overlay
      alignment = left              # default: left
      vertical_alignment = center   # values: [top/center/bottom], default: center

      corners       = all           # default: all
      corner_radius = 8             # default: 0

      progress_bar = true           # default: true
      progress_bar_height = 10      # default: 10
      progress_bar_frame_width = 0  # default: 0
      progress_bar_min_width = 250  # default: 150
      progress_bar_max_width = 500  # default: 300
      progress_bar_corners = all    # default: all
      progress_bar_corner_radius = 4 #default: 0

      icon_corners        = all     # default: all
      icon_corner_radius  = 4       # default: 0
      text_icon_padding   = 0        # default: 0
      icon_theme = "candy-icons"    # default: "Adwaita"
      enable_recursive_icon_lookup = true  # default: false

      padding            = 8        # default: 8
      horizontal_padding = 8        # default: 8
      separator_height   = 4        # default: 2
      separator_color    = auto     # default: auto   
      gap_size           = 4        # default: 0
      frame_width = 2               # default: 3

      font = "Fira Code Nerd Font 10" #default: "Monospace 8"
      line_height = 2               # default: 0
      format = "<b> %a</b>\n%s %b" # default: "<b>%s</b>\n%b"
      # explanation: <b>bold</b>; \n newline; %a app; %s summary; %b body

      mouse_left_click    = do_action      # default: close_current
      mouse_middle_click  = none           # default: do_action, remove_current
      mouse_right_click   = close_current  # default: close_all 

    [urgency_critical]
      background  = "#cc241d"
      foreground  = "#ebdbb2"
      highlight   = "#c0282f"
      frame_color = "#3c3836"
      timeout     = 10s

    [urgency_low]
      background  = "#1d2021"
      foreground  = "#ebdbb2"
      highlight   = "#28c0a7"
      frame_color = "#3c3836"
      timeout     = 1s

    [urgency_normal]
      background  = "#1d2021"
      foreground  = "#ebdbb2"
      highlight   = "#28c0a7"
      frame_color = "#3c3836"
      timeout     = 2s   
  '';
}
