{

  programs.nixvim = {

    imports = [
      ./nixvim-config.nix
      ./plugins/neo-tree.nix
      ./plugins/flash.nix
      ./plugins/persistence.nix
      ./plugins/conform.nix
      ./plugins/cmp.nix
      ./plugins/lsp.nix
      ./plugins/lspsaga.nix
      ./plugins/undotree.nix
      ./plugins/mini.nix
      ./plugins/treesitter.nix
      ./plugins/telescope.nix
      ./plugins/copilot.nix
      ./plugins/gitsigns.nix
      ./plugins/colorizer.nix
    ];

    defaultEditor = true;
    enable = true;
    nixpkgs.useGlobalPackages = true;

  };

}
