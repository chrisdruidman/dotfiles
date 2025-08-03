{
  description = "Druid machine setup flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let 
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        druidlaptop = lib.nixosSystem {
          inherit system;
          modules = [ ./laptop-configuration.nix ];
        };
      };

      homeConfigurations = {
        chrisdruidman = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./laptop-home.nix ];
        };
      };
    };
}