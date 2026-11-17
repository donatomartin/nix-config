require "mason".setup({
  registries = {
    "github:nvim-java/mason-registry",
    "github:mason-org/mason-registry",
  }
})

require "mason-tool-installer".setup({
  ensure_installed = require("lang").getDeclaredMasonPackages()
})



