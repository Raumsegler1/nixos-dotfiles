{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
    
    matugen = {
      url = "github:/InioX/Matugen";
    };

    awww.url = "git+https://codeberg.org/LGFae/awww";

    stylix = {
      url = "github:danth/stylix/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # The error happened because this part was at the very top of the file
  outputs = { self, nixpkgs, matugen, awww, stylix, ... }@inputs: {
    nixosConfigurations = {
      
      # === 1. OLD CONFIG (Safe) ===
      magnetar = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          inputs.home-manager.nixosModules.default
          stylix.nixosModules.stylix
        ];
      };

      # === 2. NEW CONFIG (Experiment) ===
      magnetar-next = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./rewrite/configuration.nix  # <--- Points to your new folder
          inputs.home-manager.nixosModules.default
        ];
      };

    };
  };
}