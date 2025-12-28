{ config, pkgs, ... }:

{
  # Matugen config for Quickshell
  # This tells Matugen how to write the qml file
  xdg.configFile."matugen/templates/quickshell.qml".text = ''
pragma Singleton
import QtQuick

QtObject {
    property color background:      "{{colors.surface.default.hex}}"
    property color foreground:      "{{colors.primary.default.hex}}"
    property color accent:          "{{colors.tertiary.default.hex}}"
    property color bordercol:       "{{colors.secondary.default.hex}}"
    property color error:           "{{colors.error.default.hex}}"

    property int   borderwidth:     0
    property int   smallradius:     4
    property int   bigradius:       8
    property int   widgetmargin:    8
    property int   widgetwidth:     30
    property int   fontsize1:       16
    property int   fontsize2:       12
    property bool  bold:            true
}
    '';

  # 2. THE CONFIG (The Instruction)
  # This tells Matugen where to find the template and where to save the result
  xdg.configFile."matugen/config.toml".text = ''
    [templates.quickshell]
    input_path = "${config.home.homeDirectory}/.config/matugen/templates/quickshell.qml"
    output_path = "${config.home.homeDirectory}/Projects/hyperion-quickshell/config/Theme.qml"
  '';
}
