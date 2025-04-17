{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.treesitter = {

      enable = true;

      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        json
        lua
        make
        markdown
        nix
        regex
        toml
        xml
        yaml
        python
        java
        html
      ];
    };
  };
}
