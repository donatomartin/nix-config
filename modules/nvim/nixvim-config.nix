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
  };

  keymaps = [
    {
      mode = "n";
      key = "<M-n>";
      action = "<cmd>b#<CR>";
      options = {
        silent = true;
        desc = "Switch to last buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>h";
      action = "<cmd>bp<CR>";
      options = {
        silent = true;
        desc = "Switch to previous buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>l";
      action = "<cmd>bn<CR>";
      options = {
        silent = true;
        desc = "Switch to next buffer";
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
