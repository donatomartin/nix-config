{ pkgs, ... }:
{
  programs.zsh.enable = true;
  programs.zsh.initContent = pkgs.lib.mkOrder 1200 ''
    source ~/.config/zsh/init.zsh
  '';
}
