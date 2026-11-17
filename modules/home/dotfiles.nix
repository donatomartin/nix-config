{ config, ... }:
let
  dotfilesDirectory = "${config.home.homeDirectory}/nix-config/dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfilesDirectory}/${path}";
in
{
  home.file = {
    ".config/hypr".source = link "hyprland";
    ".config/nvim".source = link "nvim";
    ".config/tmux".source = link "tmux";
    ".config/zsh".source = link "zsh";
  };
}
