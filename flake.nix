{
    description = "Petri's Nixos configurations";

    inputs = {

        nixpkgs.url = "nixpkgs/nixos-unstable";

        flake-utils.url = "github:numtide/flake-utils";

        darwin = {
            url = "github:LnL7/nix-darwin";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ self, nixpkgs, flake-utils, home-manager, darwin, ... }:
        let
            lib = nixpkgs.lib;
            user = "pjl";
            userName = "Petri Lehtonen";
        in {

            # Streambox - spotify streamer
            nixosConfigurations.streambox = lib.nixosSystem rec {
                pkgs = nixpkgs.legacyPackages.x86_64-linux;
                specialArgs = {
                    inherit self;
                    inherit inputs;
                    inherit user;
                    inherit userName;
                };
                system = "x86_64-linux";
                modules = [
                    ./hosts/common.nix
                    ./hosts/streambox/configuration.nix
                    home-manager.nixosModules.home-manager {
                      home-manager.useGlobalPkgs = true;
                      home-manager.useUserPackages = true;
                      home-manager.extraSpecialArgs = { 
                         inherit user;
                         inherit userName;
                      };
                      home-manager.users.${user}.imports = [
                        ./home/common.nix
                        ./home/cli.nix
                        ./home/git.nix
                        ./home/zsh
                      ];
		    }
                ];
            };


    };
}
