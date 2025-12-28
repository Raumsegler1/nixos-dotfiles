{ config, pkgs, ... }:

{
  # Matugen config for waybar
  # This tells Matugen how to write the CSS file
  xdg.configFile."matugen/templates/pywalfox-colors.json".text = ''
{
  "wallpaper": "{{image}}",
  "alpha": "100",
  "colors": {
    "color0": "{{colors.background.default.hex}}",
    "color1": "",
    "color2": "",
    "color3": "",
    "color4": "",
    "color5": "",
    "color6": "",
    "color7": "",
    "color8": "",
    "color9": "",
    "color10": "{{colors.primary.default.hex}}",
    "color11": "",
    "color12": "",
    "color13": "{{colors.surface_bright.default.hex}}",
    "color14": "",
    "color15": "{{colors.on_surface.default.hex}}"
  }
}
    '';

  # 2. THE CONFIG (The Instruction)
  # This tells Matugen where to find the template and where to save the result
  xdg.configFile."matugen/config.toml".text = ''
    [templates.pywalfox]
    input_path = '${config.home.homeDirectory}/.config/matugen/templates/pywalfox-colors.json'
    output_path = '${config.home.homeDirectory}/.cache/wal/colors.json'
    post_hook = 'pywalfox update'
  '';

  home.packages = with pkgs; [
    pywalfox-native # pywalfox-messenger
  ];
  programs.librewolf = {
    enable = true;
    nativeMessagingHosts = [ pkgs.pywalfox-native ];
    profiles.default = {
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        pywalfox
        adaptive-tab-bar-colour
        untrap-for-youtube
      ];
      settings = {
        # Stop deleting cookies on exit
        "privacy.clearOnShutdown.cookies" = false;
        "network.cookie.lifetimePolicy" = 0; # default:(0 = Keep until expiry); (2 = Session only)
        # Font
        "font.name.monospace.x-western"  = "Fira Code Nerd Font";
        # Auto-enable extensions 
        "extensions.autoDisableScopes" = 0;
        # Homepage
        #"browser.startup.homepage" = "https://nixos.org";
        "privacy.clearOnShutdown.history" = false;
        # Enable Native Vertical Tabs
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
        "browser.startup.page" = 3; # 3 = Restore previous session
      };
    };
  };
}