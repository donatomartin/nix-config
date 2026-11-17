-- Define leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Custom Options
require "options"
-- Custom AutoCmds
require "autocmds"
-- Custom Mappings
require "mappings"
-- Custom Commands
require "commands"
-- Plugin Declarations
require "plugins"
-- Custom Language Utils
require "lang".start()

