{ config, pkgs, ... }:

{
  imports = [
    ./home-modules/hypr.nix
    ./home-modules/waybar.nix
    ./home-modules/rofi.nix
    ./home-modules/scripts/wallpaperselect.nix
    ./home-modules/scripts/automatugen.nix
    ./home-modules/kitty.nix
    ./home-modules/starship.nix
    ./home-modules/macchina.nix
    ./home-modules/gtk.nix
    ./home-modules/librewolf.nix
    ./home-modules/dunst.nix
    ./home-modules/quickshell.nix
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

      # 2. Define Abbreviations
      shellAbbrs = {
        ".."     = "cd ..";
        "..."    = "cd ../..";
        "...."   = "cd ../../..";
        "....."  = "cd ../../../..";
        "......" = "cd ../../../../..";
        "ls"     = "lsd";
        "home"   = "cd /etc/nixos/";

        "system" = "bat ~/.local/share/system-cheatsheet.md";
      };
      interactiveShellInit = ''
      set fish_greeting # Disable greetings
      # A. Initialize Starship first (replaces 'starship init fish | source')
      eval (${pkgs.starship}/bin/starship init fish)

      function fish_right_prompt
          # 1. env NO_COLOR=1 forces mommy to output plain text
          # 2. --spread 5.0 makes the rainbow tighter (better for short sentences)
          env NO_COLOR=1 ${pkgs.mommy}/bin/mommy -1 -s $status | ${pkgs.lolcat}/bin/lolcat --force --spread 0.75
      end
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
        (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
          mktplcRef = {
            name = "qt-core";
            publisher = "TheQtCompany";
            version = "1.10.0";
            sha256 = "sha256-jMXC9UqvVxlvNSAMoInv3wCKyDwL/1I0TbftYjJphdU="; 
          };
        })

      ];
      userSettings = {
        "qt-qml.qmlls.useQmlImportPathEnvVar" = true;
        "extensions.autoCheckUpdates" = false;
        "security.workspace.trust.untrustedFiles" =  "open";
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
    /*theme = {
      name    = "Breeze";
      package = pkgs.kdePackages.breeze;
    };*/
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
    # Personal apps
    thunderbird-bin           # Mail client
    vesktop                   # Discord client
    kdePackages.gwenview      # Image viewer
    kdePackages.okular        # File viewer
    kdePackages.dolphin       # File manager
    kdePackages.elisa         # music player
    onlyoffice-desktopeditors # Office suite

    # Terminal utilities
    tty-clock
    cava      # audio visualizer
    macchina  # system info fetch
    lsd       # next gen ls written in rust
    mommy     # funny right fish prompt  
    lolcat    # colorful text 
    tlrc      # tldr written in rust
    imagemagick # lots of usefull commands for image processing
    wl-clipboard# useful cmds for scripts

    # Laptop functionality
    brightnessctl # controlling backlight brightness
    asusctl #laptop

    
    # gpu
    lact
    amdgpu_top
  ];

  services = {
    cliphist = {
      enable = true;  # clipboard daemon
      clipboardPackage = pkgs.wl-clipboard;
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage plain files is through 'home.file'.
  home.file = {
    ".local/share/system-cheatsheet.md".source = ./home-modules/cheatsheets/system.md;
  };

  home.sessionVariables = {
    EDITOR    = "nvim";
    VISUAL    = "codium";
    TERMINAL  = "kitty";
    BROWSER   = "chromium";
  };

  xdg.mimeApps = {
    enable = true;
  
    defaultApplications = {
      # Browser
      "text/html" = "chromium-browser.desktop";
      "x-scheme-handler/http" = "chromium-browser.desktop";
      "x-scheme-handler/https" = "chromium-browser.desktop";
      "x-scheme-handler/about" = "chromium-browser.desktop";
      "x-scheme-handler/unknown" = "chromium-browser.desktop";
      "x-scheme-handler/discord" = "vesktop.desktop";
      "x-scheme-handler/mailto" = "thunderbird.desktop";

      # Images
      "image/jpeg" = "org.kde.gwenview.desktop";
      "image/png" = "org.kde.gwenview.desktop";
      "image/gif" = "org.kde.gwenview.desktop";
      "image/webp" = "org.kde.gwenview.desktop";

      # Videos
      "video/mp4" = "org.kde.gwenview.desktop";
      "video/mkv" = "org.kde.gwenview.desktop";

      # Documents
      "application/pdf" = "org.kde.okular.desktop";
      "text/plain" = "org.kde.kwrite.desktop";
    
      # Archives (Zip, Tar, etc.)
      "application/zip" = "org.kde.ark.desktop";
      "application/x-tar" = "org.kde.ark.desktop";
      "application/x-bzip2" = "org.kde.ark.desktop";
      "application/x-gzip" = "org.kde.ark.desktop";
    };

    associations.added = {
      # Browser
      "text/html" = "chromium-browser.desktop";
      "x-scheme-handler/http" = "chromium-browser.desktop";
      "x-scheme-handler/https" = "chromium-browser.desktop";
      "x-scheme-handler/about" = "chromium-browser.desktop";
      "x-scheme-handler/unknown" = "chromium-browser.desktop";
      "x-scheme-handler/discord" = "vesktop.desktop";
      "x-scheme-handler/mailto" = "thunderbird.desktop";

      # Images
      "image/jpeg" = "org.kde.gwenview.desktop";
      "image/png" = "org.kde.gwenview.desktop";
      "image/gif" = "org.kde.gwenview.desktop";
      "image/webp" = "org.kde.gwenview.desktop";

      # Videos
      "video/mp4" = "org.kde.gwenview.desktop";
      "video/mkv" = "org.kde.gwenview.desktop";

      # Documents
      "application/pdf" = "org.kde.okular.desktop";
      "text/plain" = "org.kde.kwrite.desktop";
    
      # Archives (Zip, Tar, etc.)
      "application/zip" = "org.kde.ark.desktop";
      "application/x-tar" = "org.kde.ark.desktop";
      "application/x-bzip2" = "org.kde.ark.desktop";
      "application/x-gzip" = "org.kde.ark.desktop";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  home.stateVersion = "24.11"; # Dont change
}
