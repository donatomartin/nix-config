{
  pkgs,
  inputs,
  ...
}:
let
  profileInput = "work";
in
{
  _module.args = {
    inherit profileInput;
    javahome = pkgs.temurin-bin-17;
    lsjavahome = pkgs.temurin-bin-25;
  };

  home.username = "donato";
  home.homeDirectory = "/home/donato";

  imports = [

    ../../modules/home/dotfiles.nix

    # Services
    ../../modules/home/services/pueue.nix

    # Other
    inputs.sops-nix.homeManagerModules.sops
    ../../modules/home/development/secrets.nix
    ../../modules/home/development/nvimdeps.nix
    ../../modules/home/programs/git.nix
    ../../modules/home/programs/zsh.nix
  ];

  home.packages = with pkgs; [
    maven # java projects build automation tool
    starship # better shell prompt
    fzf # fuzzy finder
    sops # secret operations
    age # dev encryption
    python3 # python 3
    xdg-utils # xdg-utils
    bruno-cli # bruno cli
    zip # zip
    unzip # unzip
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.
}
