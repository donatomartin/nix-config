{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {

      lspkind.enable = true; # Icons for CMP
      cmp-nvim-lsp-signature-help.enable = true;

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings.sources = [

          # LSP
          { name = "nvim_lsp"; }
          { name = "nvim_lsp_signature_help"; }

          # Filesystem paths
          { name = "path"; }

          # Buffer CMP
          { name = "buffer"; }

          # Snippets
          { name = "luasnip"; }

          # Copilot
          { name = "copilot"; }

          # Dap
          { name = "cmp-dap"; }

        ];
        settings.mapping = {
          "<Tab>" = "cmp.mapping.select_next_item()";
          "<S-Tab>" = "cmp.mapping.select_prev_item()";
          "<C-j>" = "cmp.mapping.scroll_docs(4)";
          "<C-k>" = "cmp.mapping.scroll_docs(-4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-Esc>" = "cmp.mapping.close()";
          "<CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })";
        };
      };

      lsp-format.enable = true;
      none-ls = {
        enable = true;
        enableLspFormat = true;
      };

      luasnip.enable = true;
    };

    # Ability to toggle cmp
    extraConfigLua = ''
      	   local cmp_enabled = true
      	   vim.api.nvim_create_user_command("ToggleAutoComplete", function()
      		   if cmp_enabled then
      			   require("cmp").setup.buffer({ enabled = false })
      			   require("notify")("Disabled Autocomplete")
      			   cmp_enabled = false
      		   else
      			   require("cmp").setup.buffer({ enabled = true })
      			   require("notify")("Enabled Autocomplete")
      			   cmp_enabled = true
      		   end
      	   end, {})
    '';

    keymaps = [
      {
        key = "<Leader>ta";
        action = "<cmd> ToggleAutoComplete <CR>";
        mode = "n";
        options.desc = "Toggle Autocomplete";
      }
    ];
  };
}
