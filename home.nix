{ config, pkgs, ... }:

{
  imports = [
    #./modules/myModule.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "raumsegler";
  home.homeDirectory = "/home/raumsegler";

  # programs with options
  programs = {
    git = {
      enable = true;
      userName = "Raumsegler1";
      userEmail = "113139832+Raumsegler1@users.noreply.github.com";
      extraConfig = {
        pull.rebase = false;
        init.defaultBranch = "main";
      };
    };
    btop = {
      enable = true;
      settings = {
        theme_background = false; #any btop settings break the rebuild for whatever reason
        color_theme = "kyli0x";
      };
    };
    kitty = {
      enable = true;
      font = {
        package = pkgs.nerdfonts;
        name = "JetBrainsMonoNerdFont, Iosevka Nerd Font, Noto Nerd Font";
        size = 10;
      };
      settings = {
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
  };

  gtk = {
    enable = true;
    theme = {
      name = "Breeze";
      package = pkgs.kdePackages.breeze;
    };
    cursorTheme = {
      name = "bibata-cursors";
      package = pkgs.bibata-cursors;
    };
    iconTheme = {
      name = "candy-icons";
      package = pkgs.candy-icons;
    };
  };

  # The home.packages option allows you to install Nix packages into your environment.
  home.packages = with pkgs; [
    chromium
    thunderbird
    vscodium
    vesktop
    kdePackages.kate
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage plain files is through 'home.file'.
  home.file = {

  };

  home.sessionVariables = {
    EDITOR = "vscodium";
    TERMINAL = "kitty";
    SHELL = "fish";
    BROWSER = "chromium";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  home.stateVersion = "24.11"; # Dont change
}
