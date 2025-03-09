{config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = ["--all"];
    extraConfig = "
#      ${builtins.readFile ./hypr/hyprland.conf}
#      ${builtins.readFile ./hypr/animations.conf}
#      ${builtins.readFile ./hypr/rules.conf}
#      ${builtins.readFile ./hypr/theme.conf}
#      ${builtins.readFile ./hypr/keybindings.conf}
    ";
  };
}
