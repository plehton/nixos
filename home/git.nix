{...} : {
  programs.git = {
    enable = true;
    userName = "Petri Lehtonen";
    userEmail = "petri.j.lehtonen@gmail.com";
    aliases = {
      co = "checkout";
      st = "status";
      sw = "switch";
      l = "log --oneline";
    };
    extraConfig = {
      core = {
        excludeFile = "$HOME/.gitignore";
      };
    };
  };
}
