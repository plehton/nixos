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
                editor = "nvim";
            };
            merge = {
                tool = "nvim";
            };
            mergetool = {
                nvim = { cmd = "nvim -f -c \"Gdiffsplit!\" \"$MERGED\""; };
                prompt = false;
            };
            credential = {
                helper = "osxkeychain";
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
