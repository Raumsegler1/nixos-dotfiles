{ config, pkgs, ... }:

{
  # Matugen config for waybar
  # This tells Matugen how to write the CSS file
  xdg.configFile."matugen/templates/gtk-colors.css".text = ''
/*
* GTK Colors
* Generated with Matugen
*/

@define-color accent_color {{colors.primary_fixed_dim.default.hex}};
@define-color accent_fg_color {{colors.on_primary_fixed.default.hex}};
@define-color accent_bg_color {{colors.primary_fixed_dim.default.hex}};
@define-color window_bg_color {{colors.surface_dim.default.hex}};
@define-color window_fg_color {{colors.on_surface.default.hex}};
@define-color headerbar_bg_color {{colors.surface_dim.default.hex}};
@define-color headerbar_fg_color {{colors.on_surface.default.hex}};
@define-color popover_bg_color {{colors.surface_dim.default.hex}};
@define-color popover_fg_color {{colors.on_surface.default.hex}};
@define-color view_bg_color {{colors.surface.default.hex}};
@define-color view_fg_color {{colors.on_surface.default.hex}};
@define-color card_bg_color {{colors.surface.default.hex}};
@define-color card_fg_color {{colors.on_surface.default.hex}};
@define-color sidebar_bg_color @window_bg_color;
@define-color sidebar_fg_color @window_fg_color;
@define-color sidebar_border_color @window_bg_color;
@define-color sidebar_backdrop_color @window_bg_color;
  '';

  # 2. THE CONFIG (The Instruction)
  # This tells Matugen where to find the template and where to save the result
  xdg.configFile."matugen/config.toml".text = ''
    [templates.gtk3]
    input_path = '${config.home.homeDirectory}/.config/matugen/templates/gtk-colors.css'
    output_path = '~/.config/gtk-3.0/colors.css'
    post_hook = 'gsettings set org.gnome.desktop.interface gtk-theme ""; gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-{{mode}}'

    [templates.gtk4]
    input_path = '${config.home.homeDirectory}/.config/matugen/templates/gtk-colors.css'
    output_path = '~/.config/gtk-4.0/colors.css'
  '';
}
