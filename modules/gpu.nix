{config, pkgs, ... }:

{
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland and breaks boot
  services.xserver.videoDrivers = [ "nvidia" "amdgpu" ];
  boot.blacklistedKernelModules = [ "nouveau" ];

  hardware.nvidia = {
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      sync.enable = false;
      reverseSync.enable = false;

      # Make sure to use the correct Bus ID values for your system!
      nvidiaBusId = "PCI:64:0:0";
      amdgpuBusId = "PCI:65:0:0";
    };

    # Modesetting is required.
    modesetting.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    #powerManagement.finegrained = true;
    # whether to use nvidias open source or close source drivers
    open = true;
    nvidiaSettings = true;
  }; 
}
