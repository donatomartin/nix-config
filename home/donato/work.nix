{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
let
  profileInput = "work";
in
{
  home.username = "donato";
  home.homeDirectory = "/home/donato";

  imports = [
    inputs.sops-nix.homeManagerModules.sops
    ../../modules/home/services/pueue.nix
    (import ../../modules/home/development/secrets.nix {
      inherit profileInput config lib;
    })
    (import ../../modules/home/development/nvimdeps.nix {
      inherit pkgs;
      javahome = pkgs.temurin-bin-17;
      lsjavahome = pkgs.temurin-bin-25;
    })
    (import ../../modules/home/programs/git.nix {
      inherit profileInput config lib;
    })
  ];

  home.packages = with pkgs; [
    maven # java projects build automation tool
    starship # better shell prompt
    fzf # fuzzy finder
    sops # secret operations
    age # dev encryption
  ];

  programs.zsh.enable = true;
  programs.zsh.initContent = pkgs.lib.mkOrder 1200 ''
    source ~/.config/zsh/init.zsh
  '';

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
