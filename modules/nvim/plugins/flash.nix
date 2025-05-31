{ ... }:
{

  keymaps = [
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
  ];

  plugins.flash = {
    enable = true;
  };
}
