{config, pkgs, ... }:

{
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.hypyrland = {
    enable = true;
    xwayland.enable =true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = ["--all"];
    extraConfig = "
      ${builtins.readFile ./hypr/hyprland.conf}
      ${builtins.readFile ./hypr/animations.conf}
      ${builtins.readFile ./hypr/rules.conf}
      ${builtins.readFile ./hypr/theme.conf}
      ${builtins.readFile ./hypr/keybindings.conf}
    ";
  };
}