{
  programs.git = {
    enable = true;
    userName = "donatomartin";
    userEmail = "uo288787@uniovi.es";
    extraConfig = {
      init.defaultBranch = "master";
      credential.helper = "store";
    };
  };
}
