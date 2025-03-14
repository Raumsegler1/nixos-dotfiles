{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
    stylix.url = "github:danth/stylix/release-24.11";


    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, stylix, sddm-sugar-candy-nix, ... }@inputs: {
    nixosConfigurations.magnetar = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        inputs.home-manager.nixosModules.default
        stylix.nixosModules.stylix
        sddm-sugar-candy-nix.nixosModules.default
        {
          nixpkgs = {
            overlays = [
              sddm-sugar-candy-nix.overlays.default
            ];
          };
        }
      ];
    };
  };
}
