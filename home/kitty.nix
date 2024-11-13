{self, inputs, config, pkgs, ...} : {

    programs = {
        kitty = {
            enable = true;
            settings = {
                font_family = "family='JetBrainsMono Nerd Font Mono' style=Thin";
                font_size = 15;
                disable_ligatures = "always";
                macos_option_as_alt = "left";
            };
            themeFile = "rose-pine";
        };
    };
}
