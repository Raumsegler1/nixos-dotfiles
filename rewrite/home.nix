{ config, pkgs, ... }:

{
  imports = [
    ./home-modules/hypr.nix
    ./home-modules/waybar.nix
    ./home-modules/rofi.nix
    ./home-modules/scripts/wallpaperselect.nix
    ./home-modules/kitty.nix
    ./home-modules/starship.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "raumsegler";
  home.homeDirectory = "/home/raumsegler";

  # programs with options
  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          name = "Raumsegler1";
          email = "113139832+Raumsegler1@users.noreply.github.com";      
        };
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
      functions = {
        fish_right_prompt = "mommy -1 -s $status";
      };

      # 2. Define Abbreviations
      shellAbbrs = {
        ".."     = "cd ..";
        "..."    = "cd ../..";
        "...."   = "cd ../../..";
        "....."  = "cd ../../../..";
        "......" = "cd ../../../../..";
        "ls"     = "lsd";
        "home"   = "cd /etc/nixos/";
      };
      interactiveShellInit = ''
      set fish_greeting # Disable greetings
      '';
      plugins = [];
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
    vscode.profiles.default = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck =true;
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide # version doesnt match with vscodium
        kamikillerto.vscode-colorize
        (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
          mktplcRef = {
            name = "qt-qml";
            publisher = "TheQtCompany";
            version = "1.10.0";
            sha256 = "sha256-5k80WTSDwdf3WeePUt2CgTd3dTejj0+fKnbjzNfMXng="; 
          };
        })

      ];
      userSettings = {
        "qt-qml.qmlls.useQmlImportPathEnvVar" = true;
        "editor.fontFamily" = "'FiraCode Nerd Font', 'Fira Code', monospace";
        "terminal.integrated.fontFamily" = "'FiraCode Nerd Font', 'Fira Code', monospace";
      };
    };
    vscode = {
      enable = true;
      package = pkgs.vscodium;
    };
  };
  gtk = {
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

  # The home.packages option allows you to install Nix packages into your environment.
  home.packages = with pkgs; [
    thunderbird-bin
    vesktop
    kdePackages.kate
    onlyoffice-desktopeditors
    tty-clock
    cava
    tlrc
    hyprpolkitagent
    lsd # next gen ls
    mommy # fish prompt    

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
