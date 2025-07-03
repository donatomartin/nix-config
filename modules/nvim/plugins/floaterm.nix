{ ... }:
{
  keymaps = [
    {
      mode = [
        "n"
        "t"
      ];
      key = "<A-i>";
      action = "<cmd>FloatermToggle<CR>";
      options = {
        silent = true;
        desc = "Open floating terminal";
      };
    }
  ];

  plugins.floaterm = {
    enable = true;
    settings = {
      title = "Terminal";
    };
  };

  extraConfigLua = ''
    vim.api.nvim_set_hl(0, "FloatermBorder", { bg = "#1e1e2e", fg = "#b4befe" })
  '';
}
