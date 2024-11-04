{ self, inputs, config, pkgs, user, ... } :
let
  isDarwin = pkgs.stdenv.isDarwin;
in
  {

  programs.home-manager.enable = true;

  home.username = user;
  home.homeDirectory = (if isDarwin then "/Users/" else "/home/") + user;

  # Enable XDG, since we store all configs in ~/.config
  xdg.enable = true;

  imports = [
    ./zsh.nix
    ./git.nix
    ./tmux.nix
    ./cli.nix
    ./term.nix
    ./nvim.nix
  ];

  home.stateVersion = "24.05";
}

