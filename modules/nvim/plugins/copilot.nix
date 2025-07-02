{ ... }:
{

  keymaps = [
    {
      mode = "n";
      action = "<cmd>CopilotChat<CR>";
      key = "<leader>cc";
      options = {
        desc = "Open Copilot Chat";
        silent = true;
      };
    }
    {
      mode = "i";
      action = "copilot#Accept(\"\")";
      key = "<C-x>l";
      options = {
        desc = "Accept Copilot Suggestion";
        silent = true;
        expr = true;
        replace_keycodes = false;
      };
    }
    {
      mode = "i";
      action = "<Plug>(copilot-accept-line)";
      key = "<C-x>j";
      options = {
        desc = "Accept Copilot Suggestion Line";
        silent = true;
      };
    }
    {
      mode = "i";
      action = "<Plug>(copilot-suggest)";
      key = "<C-x>k";
      options = {
        desc = "Trigger Copilot Suggestion";
        silent = true;
      };
    }
    {
      mode = "i";
      action = "<Plug>(copilot-dismiss)";
      key = "<C-x>h";
      options = {
        desc = "Dismiss Copilot Suggestion";
        silent = true;
      };
    }
    {
      mode = "i";
      action = "<Plug>(copilot-next)";
      key = "<S-Tab>";
      options = {
        desc = "Next Copilot Suggestion";
        silent = true;
      };
    }
  ];

  plugins = {
    copilot-vim = {
      enable = true;
      settings = {
        no_tab_map = true;
      };
    };
    copilot-chat = {
      enable = true;
      settings = {
        mappings = {
          reset = {
            insert = "<C-c>";
            normal = "<C-c>";
          };
        };
        window = {
          layout = "replace";
        };
      };
    };
  };
}
