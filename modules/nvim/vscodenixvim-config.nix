{

  imports = [
    ./common-mappings.nix
    ./plugins/treesitter.nix
    ./plugins/flash.nix
  ];

  plugins = {
    nvim-autopairs.enable = true;
    nvim-surround.enable = true;
  };

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

  keymaps = [
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
