-- snacks.lua - Snacks.nvim basic configuration
-- Wave 1 Task 4

local M = {}

-- Set Snacks namespace
vim.g.snacks_namespace = "snacks"

-- Basic configuration (components configured in later tasks)
M.config = {
  -- Enable animations (keep default effects)
  animate = {
    enabled = true,
  },

  -- Basic notification settings
  notification = {
    enabled = true,
  },

  -- Basic styles
  styles = {
    notification = vim.empty_dict(),
  },
}

function M.setup()
  local snacks = require("snacks")

  snacks.setup(M.config)
end

return M
