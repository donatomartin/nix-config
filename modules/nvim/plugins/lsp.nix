{ pkgs, ... }:
let
  jdtlsPkg = pkgs.jdt-language-server;
  launcherJar = builtins.head (
    builtins.filter (name: builtins.match "org.eclipse.equinox.launcher_.*\\.jar" name != null) (
      builtins.attrNames (builtins.readDir "${jdtlsPkg}/share/java/jdtls/plugins")
    )
  );
in
{
  plugins = {
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        nixd.enable = true;
        html.enable = true;
        cssls.enable = true;
        tailwindcss.enable = true;
        lua_ls.enable = true;
        markdown_oxide.enable = true;
        pyright.enable = true;
        gopls.enable = true;
        yamlls.enable = true;
        eslint.enable = true;
        ts_ls.enable = true;
        clangd.enable = true;

        jdtls = {
          enable = true;
          extraOptions.cmd = [
            "${pkgs.temurin-bin-21}/bin/java"
            "-Declipse.application=org.eclipse.jdt.ls.core.id1"
            "-Dosgi.bundles.defaultStartLevel=4"
            "-Declipse.product=org.eclipse.jdt.ls.core.product"
            "-Dlog.protocol=true"
            "-Dlog.level=ALL"
            "-Xms1g"
            "-Xmx2G"
            "-javaagent:${pkgs.lombok}/share/java/lombok.jar"
            "-jar"
            "${jdtlsPkg}/share/java/jdtls/plugins/${launcherJar}"
            "-configuration"
            "/home/donato/.cache/jdtls-config/"
            "-data"
            "/home/donato/.cache/jdtls/"
          ];

        };
      };
    };
  };
  extraConfigLua = ''
    local _border = "rounded"

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
        border = _border
      }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help, {
        border = _border
      }
    )

    vim.diagnostic.config{
      float={border=_border}
    };

    require('lspconfig.ui.windows').default_options = {
      border = _border
    }

    config = function(_, opts)
      local lspconfig = require('lspconfig')
      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end;
  '';
}
