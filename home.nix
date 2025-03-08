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
      };
    };
    kitty = {
      enable = true;
      font = {
        package = pkgs.nerdfonts;
        name = "JetBrainsMonoNerdFont, Iosevka Nerd Font, Noto Nerd Font";
        size = 10;
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
    SHELL = "kitty";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  home.stateVersion = "24.11"; # Dont change
}
