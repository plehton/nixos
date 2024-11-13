{ pkgs, user, ... }:
{
    nixpkgs.hostPlatform = "aarch64-darwin";
    services.nix-daemon.enable = true;

    # Shell
    environment.loginShell = pkgs.zsh;
    environment.shells = [ pkgs.bash pkgs.zsh ];
    programs.zsh.enable = true; # default shell on catalina

    users.users.${user} = {
        home = "/Users/${user}";
    };

    environment.pathsToLink = [ "/share/zsh" ];
    environment.systemPackages = with pkgs; [
        git
        vim
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


    # MacOS Settings
    security.pam.enableSudoTouchIdAuth = true;
    system.defaults = {
        NSGlobalDomain.AppleShowAllExtensions = true;
        NSGlobalDomain.InitialKeyRepeat = 20;
        NSGlobalDomain.KeyRepeat = 2;
        dock.autohide = true;
        dock.mru-spaces = false;
        finder.AppleShowAllExtensions = true;
        finder._FXShowPosixPathInTitle = true;
        screensaver.askForPasswordDelay = 60;
    };

    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings.trusted-users = [ "root" user ];

    system.stateVersion = 5;
}
