{ self, inputs, config, ... } :
{
    programs = {
        neovim = {
            enable = true;
            viAlias = true;
            vimAlias = true;
            vimdiffAlias = true;
            #withPython3 = true;
            #withNodeJs= true;
            #withRuby = true;
        };
    };

    # xdg.configFile = {
    #     "nvim" = {
    #         enable = true;
    #         recursive = true;
    #         source = config.lib.file.mkOutOfStoreSymlink (builtins.toString "${d}/home/config/nvim");
    #     };
    # };

}
