{ config, pkgs, ... }:

{
  imports = [
    ./home-modules/hypr.nix
    ./home-modules/waybar.nix
    ./home-modules/rofi.nix
    ./home-modules/scripts/wallpaperselect.nix
    ./home-modules/kitty.nix
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
        safe.directory = "/etc/nixos";
      };
    };
    btop = {
      enable = true;
      settings = {
        theme_background = false;
        #color_theme = "kyli0x";
      };
    };
    fish = {
      enable = true;
      plugins = [];
    };
    starship = {
      enable = true;
      enableFishIntegration = true;
      # Configuration written to ~/.config/starship.toml
      settings = {
        # add_newline = false;

        # character = {
        #   success_symbol = "[➜](bold green)";
        #   error_symbol = "[➜](bold red)";
        # };

        # package.disabled = true;
      };
    };
    chromium = {
      extensions = [
        {
          id = "nngceckbapebfimnlniiiahkandclblb"; # Bitwarden
        }
        {
          id = "ddkjiahejlhfcafbddmgiahcphecmpfh";  # uBlock Origin Lite
        }
      ];
      enable = true;
    };
    librewolf = {
      enable = true;
    };
    vscode = {
      enable = true;
      package = pkgs.vscodium;
      enableExtensionUpdateCheck = false;
      enableUpdateCheck =true;
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide # version doesnt match with vscodium
        kamikillerto.vscode-colorize

      ];
      userSettings = {

      };
    };
  };

/*  gtk = {
    enable = true;
    theme = {
      name    = "Breeze";
      package = pkgs.kdePackages.breeze;
    };
    cursorTheme = {
      name    = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
    iconTheme = {
      name    = "candy-icons";
      package = pkgs.candy-icons;
    };
  };
*/
  # The home.packages option allows you to install Nix packages into your environment.
  home.packages = with pkgs; [
    thunderbird
    vesktop
    kdePackages.kate
    onlyoffice-desktopeditors
    tty-clock
    tlrc

    hyprpolkitagent    

    # gpu
    lact
    amdgpu_top
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage plain files is through 'home.file'.
  home.file = {

  };

  home.sessionVariables = {
    EDITOR    = "nvim";
    VISUAL    = "codium";
    TERMINAL  = "kitty";
    BROWSER   = "chromium";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  home.stateVersion = "24.11"; # Dont change
}
