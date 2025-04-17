{ pkgs, inputs, ... }:
{

  imports = [
    ./plugins
    ./mappings.nix
    ./options.nix
  ];

  programs.nixvim = {

    enable = true;
    enableMan = true;
    defaultEditor = true;
    clipboard.register = "unnamedplus,unnamed";
    nixpkgs.useGlobalPackages = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

  };
}
