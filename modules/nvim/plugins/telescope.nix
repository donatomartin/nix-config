{

  keymaps = [
    {
      mode = "n";
      key = "<leader>ff";
      action.__raw = ''
        function()
          require("telescope.builtin").find_files({
            find_command = {
              "fd",
              "--type=f",
              "--hidden",
              "--no-ignore",
              "--exclude", ".git",
              "--exclude", "node_modules",
              "--exclude", "target"
            }
          })
        end
      '';
      options = {
        desc = "Find files with fd";
      };

    }
  ];

  plugins.telescope = {

    enable = true;

    keymaps = {
      "<leader>fw" = "live_grep";
      "<leader>fb" = "buffers";
      "<leader>fh" = "help_tags";
      "<leader>fm" = "marks";
      "<leader>fc" = "git_commits";
      "<leader>fd" = "diagnostics";
      "<leader>fr" = "registers";
      "<leader>fo" = "oldfiles";
      "<leader>fa" = "find_files follow=true no_ignore=true hidden=true";
      "<leader>fW" = "current_buffer_fuzzy_find";
      "<leader>fg" = "git_status";
      "<leader>fz" = "zoxide list";
      "<leader>fu" = "undo";
    };

    extensions = {
      zoxide.enable = true;
      frecency.enable = true;
      undo.enable = true;
    };

    settings.defaults = {
      set_env.COLORTERM = "truecolor";
      path_display = [ "truncate" ];
    };

  };
}
