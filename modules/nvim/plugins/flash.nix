{
  programs.nixvim = {

    keymaps = [
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "s";
        action = ":lua require('flash').jump()<CR>";
        options = {
          desc = "Flash";
        };
      }
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "S";
        action = ":lua require('flash').treesitter()<CR>";
        options = {
          desc = "Flash Treesitter";
        };
      }
      {
        mode = "o";
        key = "r";
        action = ":lua require('flash').remote()<CR>";
        options = {
          desc = "Remote Flash";
        };
      }
      {
        mode = [
          "o"
          "x"
        ];
        key = "R";
        action = ":lua require('flash').treesitter_search()<CR>";
        options = {
          desc = "Treesitter Search";
        };
      }
      {
        mode = "c";
        key = "<C-s>";
        action = ":lua require('flash').toggle()<CR>";
        options = {
          desc = "Toggle Flash Search";
        };
      }
    ];

    plugins.flash = {
      enable = true;

      settings = { };

    };
  };
}
