{ config, pkgs, ... }:

{
  # Matugen config for Quickshell
  # This tells Matugen how to write the qml file
  xdg.configFile."matugen/templates/quickshell.qml".text = ''
import QtQuick

QtObject {
    property color background   :   "{{colors.surface.default.hex}}"
    property color on_background:   "{{colors.on_surface.default.hex}}"

    property color foreground   :   "{{colors.primary.default.hex}}"

    property color hover        :   "{{colors.secondary.default.hex}}"
    property color accent       :   "{{colors.tertiary.default.hex}}"
    property color accent2      :   "{{colors.primary.default.hex}}"
    property color accent3      :   "{{colors.primary.default.hex}}"
    property color accent4      :   "{{colors.primary.default.hex}}"

    property color bordercol    :   "{{colors.inverse_primary.default.hex}}"
    property color error        :   "{{colors.on_error.default.hex}}"
}
    '';

  # 2. THE CONFIG (The Instruction)
  # This tells Matugen where to find the template and where to save the result
  xdg.configFile."matugen/config.toml".text = ''
    [templates.quickshell]
    input_path = "${config.home.homeDirectory}/.config/matugen/templates/quickshell.qml"
    output_path = "${config.home.homeDirectory}/Projects/calypso/config/colors/Matugen.qml"
  '';
}
