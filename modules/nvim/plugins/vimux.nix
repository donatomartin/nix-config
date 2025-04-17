{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = ";";
        action = "<cmd>VimuxPromptCommand<CR>";
        options = {
          silent = true;
          desc = "Execute terminal command";
        };
      }
    ];
    plugins.vimux.enable = true;
  };
}
