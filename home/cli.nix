{ pkgs, ... } : {

  programs = {
    bat.enable = true;
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd --type f --follow --hidden --exclude .git";
    };
    gh = {
      enable = true;
    };
    z-lua = {
      enable = true;
      enableZshIntegration = true;
      options = [ "once" "fzf" ];
    };
  };

  home.packages = with pkgs; [

    # Base
    (nerdfonts.override { fonts = [ "BitstreamVeraSansMono" "FiraCode" "JetBrainsMono" ]; })
    curl
    fd
    lazygit
    ripgrep
    tree

    # Work
    awscli2
    fswatch
    databricks-cli
    jq

    # Dev
    devenv
  ];

}
