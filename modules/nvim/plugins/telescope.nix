{
  plugins.telescope = {
    enable = true;

    keymaps = {
      # Find files using Telescope command-line sugar.
      "<leader>ff" = "find_files";
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
      "<leader>fx" = "manix";
    };

    settings.defaults = {
      file_ignore_patterns = [
        "^.git/"
        "^.mypy_cache/"
        "^__pycache__/"
        "^output/"
        "^data/"
        "%.ipynb"
        "^node_modules/"
      ];
      set_env.COLORTERM = "truecolor";
      path_display = [ "truncate" ];
    };

    extensions = {
      zoxide.enable = true;
      frecency.enable = true;
      manix.enable = true;
      undo.enable = true;
    };
  };
}
