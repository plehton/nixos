{
    description = "Petri's Nixos configurations";

    inputs = {

        nixpkgs.url = "nixpkgs/nixos-unstable";

        flake-utils.url = "github:numtide/flake-utils";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

    outputs = inputs@{ self, nixpkgs, flake-utils, home-manager, nixos-wsl, darwin, ... }:
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
                    ./hosts/streambox
                    ./hosts/common.nix

                ];
            };


        };
}
