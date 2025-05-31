{
  plugins.treesitter = {
    enable = true;
    settings = {
      auto_install = false;
      ensure_installed = [
        "java"
        "nix"
        "python"
        "go"
        "c"
        "html"
        "css"
        "javascript"
        "typescript"
        "yaml"
        "json"
        "lua"
      ];
      highlight = {
        additional_vim_regex_highlighting = true;
        enable = true;
      };
      incremental_selection = {
        enable = true;
        keymaps = {
          init_selection = "<Enter>";
          node_incremental = "<Enter>";
          node_decremental = "<Backspace>";
          scope_incremental = "<Tab>";
        };
      };
      indent = {
        enable = true;
      };
      parser_install_dir = {
        __raw = "vim.fs.joinpath(vim.fn.stdpath('data'), 'treesitter')";
      };
      sync_install = false;
    };
  };
}
