{ pkgs, ... }:
{
  keymaps = [
    {
      mode = "n";
      key = "<leader>mm";
      action = "<cmd>lua require('conform').format()<CR>";
      options = {
        desc = "format";
        silent = true;
      };
    }
  ];

  extraPackages = with pkgs; [
    shfmt
    nixfmt-rfc-style
    stylua
    nodePackages.prettier
    prettierd
    black
    google-java-format
    isort
  ];

  plugins.conform-nvim = {
    enable = true;

    settings = {
      format_on_save = {
        lspFallback = true;
        timeoutMs = 500;
      };
      notify_on_error = true;

      formatters_by_ft = {
        html = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        css = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        javascript = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        javascriptreact = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        typescript = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        typescriptreact = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        python = [
          "black"
          "isort"
        ];
        lua = [ "stylua" ];
        nix = [ "nixfmt" ];
        markdown = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        yaml = [
          "yamllint"
          "yamlfmt"
        ];
        bash = [ "shfmt" ];
        sh = [ "shfmt" ];
        java = [ "google-java-format" ];
      };
    };
  };
}
