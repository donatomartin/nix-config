{ ... }:
{

  # Configured plugins
  imports = [
    ./neo-tree.nix
    ./telescope.nix
    ./flash.nix
    ./persistence.nix
    ./conform.nix
    ./cmp.nix
    ./lsp.nix
    ./lspsaga.nix
    ./undotree.nix
    ./mini.nix
    ./harpoon.nix
    ./treesitter.nix
    ./copilot.nix
    ./extra-plugins.nix
    ./gitsigns.nix
  ];

  # Default Configuration Plugins
  programs.nixvim = {
    plugins = {
      web-devicons.enable = true; # Icons
      nvim-autopairs.enable = true; # Autopairing
      nvim-surround.enable = true; # Surround
      which-key.enable = true; # Bind hints
      zen-mode.enable = true; # Enable zen mode
      vim-suda.enable = true; # Write files with sudo
      oil.enable = true; # Oil file explorer
    };
  };

}
