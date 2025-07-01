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
      key = "<Right>";
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
      key = "<Down>";
      options = {
        desc = "Accept Copilot Suggestion Line";
        silent = true;
      };
    }
    {
      mode = "i";
      action = "<Plug>(copilot-suggest)";
      key = "<Up>";
      options = {
        desc = "Trigger Copilot Suggestion";
        silent = true;
      };
    }
    {
      mode = "i";
      action = "<Plug>(copilot-dismiss)";
      key = "<Left>";
      options = {
        desc = "Dismiss Copilot Suggestion";
        silent = true;
      };
    }
    {
      mode = "i";
      action = "<Plug>(copilot-next)";
      key = "<C-<Right>>";
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
