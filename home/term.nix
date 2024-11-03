{self, inputs, config, pkgs, ...} : {

    programs = {
        kitty = {
            enable = true;
        };
    };

    home.packages = [
    	pkgs.wezterm
    ];

    xdg.configFile = {
        "wezterm" = {
            enable = true;
            recursive = true;
            source = config.lib.file.mkOutOfStoreSymlink "${self.outPath}/home/config/wezterm";
        };
    };

}
