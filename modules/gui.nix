{inputs, ...} : {
  programs = {
    kitty = {
      enable = true;
    };

    wezterm = {
      enable = true;
      extraConfig = builtins.readFile "${inputs.dotfiles}/wezterm/wezterm.lua";
    };
  };
}
