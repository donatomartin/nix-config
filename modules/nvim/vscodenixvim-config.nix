{

  imports = [
    ./plugins/treesitter.nix
  ];

  clipboard.register = "unnamedplus,unnamed";

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

  plugins = {
    nvim-autopairs.enable = true;
    nvim-surround.enable = true;
    flash.enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>c";
      action = "<cmd>%y+<CR>";
      options = {
        silent = true;
        desc = "copy whole file";
      };
    }
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "s";
      action = "<cmd>lua require('flash').jump()<CR>";
      options = {
        desc = "Flash";
      };
    }
    {
      mode = [
        "o"
        "x"
      ];
      key = "S";
      action = "<cmd>lua require('flash').treesitter_search()<CR>";
      options = {
        desc = "Treesitter Search";
      };
    }
    {
      mode = "n";
      key = "<Esc>";
      action = "<cmd>noh<CR>";
      options = {
        silent = true;
        desc = "Clear highlights";
      };
    }
    {
      mode = "n";
      key = ";";
      action = "<cmd>lua vim.api.nvim_feedkeys(':! ', 'm', true)<CR>";
      options = {
        silent = true;
        desc = "Execute terminal command";
      };
    }
    {
      mode = "n";
      key = "<leader>n";
      action = "<cmd>call VSCodeNotify('workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup')<CR>";
      options = {
        silent = true;
        desc = "Switch to last buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>h";
      action = "<cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>";
      options = {
        silent = true;
        desc = "previous editor";
      };
    }
    {
      mode = "n";
      key = "<leader>l";
      action = "<cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>";
      options = {
        silent = true;
        desc = "next Editor";
      };
    }
    {
      mode = "n";
      key = "gD";
      action = "<cmd>call VSCodeNotify('editor.action.revealDeclaration')<CR>";
      options = {
        silent = true;
        desc = "";
      };
    }
    {
      mode = "n";
      key = "gd";
      action = "<cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>";
      options = {
        silent = true;
        desc = "";
      };
    }
    {
      mode = "n";
      key = "gi";
      action = "<cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>";
      options = {
        silent = true;
        desc = "";
      };
    }
    {
      mode = "n";
      key = "<leader>ff";
      action = "<cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>";
      options = {
        silent = true;
        desc = "Go to file";
      };
    }
    {
      mode = "n";
      key = "<leader>z";
      action = "<cmd>call VSCodeNotify('projectManager.listProjects')<CR>";
      options = {
        silent = true;
      };
    }

  ];

}
