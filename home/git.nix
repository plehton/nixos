{...} : {
    programs.git = {
        enable = true;
        userName = "Petri Lehtonen";
        userEmail = "petri.j.lehtonen@gmail.com";
        aliases = {
            cm = "commit -m";
            co = "checkout";
            st = "status";
            sw = "switch";
            l = "log --oneline";
        };
        extraConfig = {
            core = {
                excludeFile = "$HOME/.gitignore";
                editor = "vim";
            };
            merge = {
                tool = "vim";
            };
            pull = {
                rebase = true;
            };
            push = {
                autoSetupRemote = true;
            };
            fetch = {
                prune = true;
            };
        };
    };
}
