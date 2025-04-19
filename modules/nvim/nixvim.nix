{
  pkgs,
  inputs,
  ...
}:
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
    colorschemes.catppuccin.enable = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    extraConfigLua = ''
      vim.filetype.add {
        extension = {
          g4 = "antlr4",
        },
      }
    '';
  };

  home.file.".config/nvim/syntax/antlr4.vim".source = ./syntax/antlr4.vim;
}
