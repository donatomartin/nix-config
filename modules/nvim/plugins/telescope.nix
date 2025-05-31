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
      "<leader>fc" = "git_commit";
      "<leader>fd" = "diagnostics";
      "<leader>fr" = "registers";
      "<leader>fo" = "oldfiles";
      "<leader>fa" = "find_files follow=true no_ignore=true hidden=true";
      "<leader>fz" = "current_buffer_fuzzy_find";
      "<leader>fg" = "git_status";
    };

    settings.defaults = {
      file_ignore_patterns = [
        "^.git/"
        "^.mypy_cache/"
        "^__pycache__/"
        "^output/"
        "^data/"
        "%.ipynb"
      ];
      set_env.COLORTERM = "truecolor";
    };
  };
}
