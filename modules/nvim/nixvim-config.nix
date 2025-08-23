{

  imports = [
    ./snippets.nix
    ./autocmd.nix
    ./common-mappings.nix
    ./plugins/neo-tree.nix
    ./plugins/flash.nix
    ./plugins/persistence.nix
    ./plugins/conform.nix
    ./plugins/cmp.nix
    ./plugins/lsp.nix
    ./plugins/lspsaga.nix
    ./plugins/dap.nix
    ./plugins/undotree.nix
    ./plugins/mini.nix
    ./plugins/treesitter.nix
    ./plugins/telescope.nix
    ./plugins/copilot.nix
    ./plugins/gitsigns.nix
    ./plugins/colorizer.nix
    ./plugins/floaterm.nix
    ./plugins/harpoon.nix
    ./plugins/menu.nix
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
    lualine.enable = true; # Statusline
  };

  keymaps = [
    {
      mode = "n";
      key = "<A-h>";
      action = "<cmd>vertical resize +2<CR>";
      options = {
        silent = true;
        desc = "Resize split left";
      };
    }
    {
      mode = "n";
      key = "<A-l>";
      action = "<cmd>vertical resize -2<CR>";
      options = {
        silent = true;
        desc = "Resize split right";
      };
    }
    {
      mode = "n";
      key = "<A-j>";
      action = "<cmd>resize -2<CR>";
      options = {
        silent = true;
        desc = "Resize split down";
      };
    }
    {
      mode = "n";
      key = "<A-k>";
      action = "<cmd>resize +2<CR>";
      options = {
        silent = true;
        desc = "Resize split up";
      };
    }
  ];

  enableMan = true;
  clipboard.register = "unnamedplus,unnamed";
  colorschemes.catppuccin.enable = true;

  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  opts = {

    relativenumber = true;
    number = true;
    swapfile = false;
    mouse = "a";
    undofile = true;

    # Indenting
    expandtab = true;
    shiftwidth = 2;
    smartindent = true;
    tabstop = 2;
    softtabstop = 2;

  };

}
