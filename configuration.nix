# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      #"${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/common/gpu/nvidia"
      #"${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/common/hidpi.nix"
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader
  boot = {
    #loader = {
      #systemd-boot.enable = true;
      #efi.canTouchEfiVariables = true;
    #};
    #kernelParams = [ "nouveau.modeset=0" ];
  };

  # Enable GRUB
  boot.loader.grub = {
    enable = true;
    efiSupport = true;          # Enable EFI support
    device = "nodev";           # Use "nodev" for UEFI systems
    efiInstallAsRemovable = true; # Ensure GRUB is installed in a way UEFI can find
    useOSProber = true;         # Automatically detect other operating systems
    extraEntries = "
      menuentry 'Enter BIOS Setup' {
      echo 'Rebooting into BIOS setup...'
      fwsetup
      reboot
      }";
    theme = "/etc/nixos/virtuaverse";
  };


  networking.hostName = "magnetar"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
    };
    #theme = "/etc/nixos/sakura-sddm-theme/pixel_sakura.conf";
    #settings = {};
  };
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false; # Disable PulseAudio
  security.rtkit.enable = true;       # Enable real-time support
  services.pipewire = {
    enable = true;                     # Enable PipeWire
    alsa = {
      enable = true;                   # Enable ALSA support
      support32Bit = true;             # Enable 32-bit ALSA support
    };
    pulse = {
      enable = true;                   # Enable PulseAudio support in PipeWire
    };
    jack = {
      enable = true;                   # Enable JACK support (if needed)
    };
    wireplumber.enable = true;
  };

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland and breaks boot
  #services.xserver.videoDrivers = [ "nvidia" ];
  #boot.blacklistedKernelModules = [ "nouveau" ];

  /*hardware.nvidia = {
    prime = {
      offload = {
        #enable = true;
        #enableOffloadCmd = true;
      };
      # Make sure to use the correct Bus ID values for your system!
      nvidiaBusId = "PCI:64:0:0";
      amdgpuBusId = "PCI:65:0:0";
    };

    # Modesetting is required.
    modesetting.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    #powerManagement.finegrained = true;
    open = false;
    nvidiaSettings = true;
  }; *//*
  hardware.nvidia =  {
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
	  version = "550.120";
    sha256_64bit = "sha256-gBkoJ0dTzM52JwmOoHjMNwcN2uBN46oIRZHAX8cDVpc=";
    sha256_aarch64 = "sha256-mVEeFWHOFyhl3TGx1xy5EhnIS/nRMooQ3+LdyGe69TQ=";
	  openSha256 = "sha256-Po+pASZdBaNDeu5h8sgYgP9YyFAm9ywf/8iyyAaLm+w=";
    settingsSha256 = "sha256-fPfIPwpIijoUpNlAUt9C8EeXR5In633qnlelL+btGbU=";
	  persistencedSha256 = "sha256-Vz33gNYapQ4++hMqH3zBB4MyjxLxwasvLzUJsCcyY4k=";
    };
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    dynamicBoost.enable = true;
    #powerManagement.enable = true;
    powerManagement.finegrained = true;
    #nvidiaPersistenced = true;


    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      amdgpuBusId = "PCI:65:0:0";
      nvidiaBusId = "PCI:64:0:0";
    };
  };
*/
  powerManagement.enable = true;
  services.power-profiles-daemon.enable = false;

  services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 60;
      };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.raumsegler = {
    isNormalUser = true;
    description = "raumsegler";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "raumsegler" = import ./home.nix;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup3"; # Makes automatic Backups in case of conflicting files

  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  neovim
  nh
  wget
  chromium
  thunderbird
  vscodium
  lshw
  btop
  git
  primusLib
  ];

  fonts.packages = with pkgs; [
    zpix-pixel-font
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = 1;
  programs.hyprland = {
    enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
