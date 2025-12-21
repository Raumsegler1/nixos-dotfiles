{ config, pkgs, ... }:

{
  imports = [
    ./home-modules/hypr.nix
    ./home-modules/waybar.nix
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
    kitty = {
      enable = true;
      font = {
        package = pkgs.nerdfonts;
        name = "Iosevka Nerd Font";
        size = 12;
      };

      shellIntegration.enableFishIntegration = true;

      settings = {
        shell = "${pkgs.fish}/bin/fish";

        #fonts = "JetBrainsMonoNerdFont, Iosevka Nerd Font, Noto Nerd Font";
        window_margin_width = 0;
        window_padding_width = 4;
        confirm_os_windows_close = 0;

        #background_opacity = 1;
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
