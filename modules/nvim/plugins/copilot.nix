{
  programs.nixvim = {
    plugins = {
      copilot-chat.enable = true;
      copilot-vim.enable = true;
    };
  };
}
