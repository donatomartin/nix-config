{

  keymaps = [
    {
      mode = "n";
      key = "<leader>qs";
      action = ":lua require('persistence').load()<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>qS";
      action = ":lua require('persistence').select()<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>ql";
      action = ":lua require('persistence').load({ last = true })<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>qd";
      action = ":lua require('persistence').stop()<CR>";
      options.silent = true;
    }
  ];

  plugins.persistence.enable = true;
}
