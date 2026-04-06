-- init.lua - Neovim configuration entry point
-- Loading order: options → keymaps → plugins → layouts

-- Bootstrap vim.pack (Neovim 0.12+ built-in plugin manager)
vim.g.loaded_vim_pack = 1

-- Load user settings
require('config.options')
require('config.keymaps')

-- Load plugins (must be after options/keymaps)
require('config.plugins')
require('plugins.mason').setup()
require('plugins.completion').setup()
require('plugins.lsp').setup()
require('plugins.dap').setup()
require('plugins.ui').setup()
require('plugins.treesitter').setup()

-- Load layouts
require('config.layouts')
