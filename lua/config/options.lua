-- options.lua
-- Neovim core editor options

-- Basic options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Search options
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Appearance options
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true

-- Performance options
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- System options
vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = 'a'
vim.opt.undofile = true

-- Filetype detection for JavaScript/TypeScript
vim.filetype.add({
  extension = {
    mts = "typescript",
    cts = "typescript",
  },
  filename = {
    ["dts.config.js"] = "typescript",
    ["tsconfig.json"] = "jsonc",
  },
})
