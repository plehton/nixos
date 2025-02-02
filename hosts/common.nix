{ pkgs, user, ... }:
let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
    # Shell
    environment.shells = [ pkgs.bash pkgs.zsh ];
    programs.zsh.enable = true;

    users.defaultUserShell = pkgs.zsh;

    users.users.${user} = {
        home = (if isDarwin then "/Users/" else "/home/") + user;
    };

    environment.pathsToLink = [ "/share/zsh" ];
    environment.systemPackages = with pkgs; [
        git
        vim
        openssh
    ];

    environment.etc.vimrc.text = ''
        syntax on
        filetype indent plugin on
        nmap , :
        set tabstop=4
        set shiftwidth=4
        set softtabstop=4
        set expandtab
        set autoindent
        '';
}


