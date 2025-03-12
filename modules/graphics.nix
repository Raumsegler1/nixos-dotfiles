{config, pkgs, ... }:

{
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
}
