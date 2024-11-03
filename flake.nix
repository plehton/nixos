{
  description = "Petri's NixOS";

  inputs = {

    nixpkgs.url = "nixpkgs/nixos-unstable";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Use my dotfiles as input
    dotfiles = {
      url = "github:plehton/dotfiles";
      flake = false;
    };

  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixos-wsl, darwin, ... }:
    let
      lib = nixpkgs.lib;
      user = "pjl";
      userName = "Petri Lehtonen";
    in {

      # Macbook
      darwinConfigurations.MV9J7YK4N9 = darwin.lib.darwinSystem rec {
        specialArgs = {
          inherit user;
          inherit inputs;
          inherit self;
        };
        modules = [
          ./hosts/macbook
          home-manager.darwinModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = specialArgs;
              backupFileExtension = "oli";
              users.${user}.imports = [ ./home ];
            };
          }
        ];
      };

      # UTM VM
      nixosConfigurations.utmos= lib.nixosSystem rec {
        pkgs = nixpkgs.legacyPackages.aarch64-linux;
        specialArgs = {
          inherit self;
          inherit inputs;
          inherit user;
          inherit userName;
        };
        system = "aarch64-linux";
        modules = [
          ./hosts/utm
          .home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "oli";
              users.${user}.imports = [ ./home ];
              extraSpecialArgs = specialArgs;
            };
          }
        ];
      };

    };
}
