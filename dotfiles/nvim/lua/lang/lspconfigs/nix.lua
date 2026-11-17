vim.lsp.config["my_nixd"] = {
  cmd = { "nixd" },
  filetypes = { "nix" },
  root_markers = { "flake.nix", ".git" },

  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },

      formatting = {
        command = { "nixfmt" },
      },

      options = {
        nixos = {
          expr = '(builtins.getFlake (builtins.toString ./.)).nixosConfigurations."nixos".options',
        },

        home_manager = {
          expr = '(builtins.getFlake (builtins.toString ./.)).nixosConfigurations."nixos".options.home-manager.users.type.getSubOptions []',
        },
      },
    },
  },
}

vim.lsp.enable("my_nixd")
