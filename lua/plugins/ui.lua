-- ui.lua - UI plugin configurations
-- Task 25: lualine.nvim status bar

local M = {}

-- Configure lualine status bar
M.config_lualine = function()
  require('lualine').setup({
    options = {
      theme = 'auto',
      globalstatus = true,
      icons_enabled = true,
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {},
      always_divide_middle = true,
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diagnostics' },
      lualine_c = { 'filename' },
      lualine_x = {},
      lualine_y = { 'filetype' },
      lualine_z = { 'progress', 'location' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  })
end

-- Setup function to be called from init.lua
function M.setup()
  M.config_lualine()
  
  -- Enable global status line (laststatus = 3)
  vim.o.laststatus = 3
end

return M
