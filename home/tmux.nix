{inputs, pkgs, ...}:{
    home.packages = [
        pkgs.reattach-to-user-namespace
        pkgs.tmux
        ];
    xdg.configFile."tmux/tmux.conf" = {
        enable = true;
        source = "${inputs.dotfiles}/tmux/tmux.conf";
    };
}
