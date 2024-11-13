{ self, inputs, pkgs, user, ... } :
let
  isDarwin = pkgs.stdenv.isDarwin;
in
  {

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = "_";

  home.username = user;
  home.homeDirectory = (if isDarwin then "/Users/" else "/home/") + user;

  # Enable XDG, since we store all configs in ~/.config
  xdg.enable = true;

  imports = [
    ./cli.nix
    ./git.nix
    ./kitty.nix
    ./nvim.nix
    ./tmux.nix
    ./zsh
  ];

  home.stateVersion = "24.05";
}

