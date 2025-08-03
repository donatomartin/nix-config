{ ... }:
{
  programs.ranger = {
    enable = true;
    aliases = {
      "d" = "delete";
      "c" = "copy";
      "x" = "cut";
      "r" = "rename";
      "Z" = "z";
    };
    plugins = [
      {
        name = "zoxide";
        src = builtins.fetchGit {
          url = "https://github.com/jchook/ranger-zoxide.git";
          rev = "363df97af34c96ea873c5b13b035413f56b12ead";
        };
      }
    ];
  };
}
