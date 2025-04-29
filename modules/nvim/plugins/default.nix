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
    ./dap.nix
    ./undotree.nix
    ./mini.nix
    ./floaterm.nix
    ./harpoon.nix
    ./treesitter.nix
    ./copilot.nix
    ./lazygit.nix
    ./extra-plugins.nix
    ./gitsigns.nix
  ];

  # Default Configuration Plugins
  programs.nixvim = {
    plugins = {
      lz-n.enable = true; # Lazy Loading
      web-devicons.enable = true; # Icons
      nvim-autopairs.enable = true; # Autopairing
      nvim-surround.enable = true; # Surround
      which-key.enable = true; # Bind hints
      flash.enable = true; # Move fast
      tmux-navigator.enable = true; # Tmux integration
      markview.enable = true; # Markdown viewer
      zen-mode.enable = true; # Enable zen mode
      vim-suda.enable = true; # Write files with sudo
      colorizer.enable = true; # Highlight colors
      lualine.enable = true; # Cooler line
      comment-box.enable = true; # Nicer comments
    };
  };

}
