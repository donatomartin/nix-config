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

    # Default Configuration Plugins
    plugins = {
      web-devicons.enable = true; # Icons
      nvim-autopairs.enable = true; # Autopairing
      nvim-surround.enable = true; # Surround
      which-key.enable = true; # Bind hints
      zen-mode.enable = true; # Enable zen mode
      vim-suda.enable = true; # Write files with sudo
      oil.enable = true; # Oil file explorer
      tmux-navigator.enable = true; # Tmux integration
      fugitive.enable = true; # Git integration
    };

    defaultEditor = true;
    enable = true;
    nixpkgs.useGlobalPackages = true;

  };

}
