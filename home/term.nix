{self, inputs, config, pkgs, ...} : {

    programs = {
        kitty = {
            enable = true;
            settings = {
                font_family = "family='JetBrainsMono Nerd Font Mono' style=Light";
                font_size = 15;
            };
            themeFile = "rose-pine";
        };
        wezterm = {
            enable = true;
        };
    };

}
