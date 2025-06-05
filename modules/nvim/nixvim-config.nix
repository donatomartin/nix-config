{

  imports = [
    ./plugins
    ./snippets.nix
    ./autocmd.nix
    ./general-mappings.nix
  ];

  enableMan = true;
  clipboard.register = "unnamedplus,unnamed";
  colorschemes.catppuccin.enable = true;

  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  opts = {

    relativenumber = true;
    number = true;
    swapfile = false;
    mouse = "a";
    undofile = true;

    # Indenting
    expandtab = true;
    shiftwidth = 2;
    smartindent = true;
    tabstop = 2;
    softtabstop = 2;

  };

  extraConfigLua = ''
    vim.api.nvim_create_user_command("BOnly", function()
      local current = vim.api.nvim_get_current_buf()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end
    end, {})
  '';

}
