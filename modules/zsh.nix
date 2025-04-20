{ pkgs, ... }:
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
      ll = "ls -a";
      lla = "ls -la";
    };
    oh-my-zsh = {
      enable = true;
      theme = "agnoster"; # puedes cambiarlo por otro
      plugins = [
        "git"
        "zoxide"
        "extract"
        "vi-mode"
        "tmux"
      ];
      extraConfig = ''
        ZSH_TMUX_AUTOSTART=true
        ZSH_TMUX_AUTOQUIT=false
        ZSH_TMUX_AUTOCONNECT=false
      '';
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
