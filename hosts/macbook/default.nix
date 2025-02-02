{ pkgs, user, ... }:
{
    nixpkgs.hostPlatform = "aarch64-darwin";
    services.nix-daemon.enable = true;

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
