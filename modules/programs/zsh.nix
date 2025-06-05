{ ... }:
{

  programs.zsh = {

    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    shellAliases = {
      vim = "nvim";
      nv = "nvim";
      vi = "nvim";
      v = "nvim";
      l = "ls";
      la = "ls -a";
      ll = "ls -l";
      lla = "ls -la";
    };

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [
        "git"
        "zoxide"
        "extract"
        "vi-mode"
        "tmux"
        "sudo"
      ];
      extraConfig = ''
        VI_MODE_CURSOR_NORMAL=1
        VI_MODE_SET_CURSOR=true
        VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=false
      '';
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

}
