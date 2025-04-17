{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    shellAliases = {
      vim = "nvim";
    };
    oh-my-zsh = {
      enable = true;
      theme = "agnoster"; # puedes cambiarlo por otro
      plugins = [ "git" "zoxide" "extract" "vi-mode" "tmux" ];
      extraConfig = "ZSH_TMUX_AUTOSTART=true";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
