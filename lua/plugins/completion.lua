-- completion.lua - blink.cmp completion configuration
-- Wave 2 Task 11

local M = {}

function M.setup()
  require('blink.cmp').setup({
    -- Keymap preset: 'default' (C-y to accept) or 'super-tab'
    keymap = { preset = 'super-tab' },

    -- Appearance options
    appearance = {
      nerd_font_variant = 'mono', -- or 'normal'
    },

    -- Completion behavior
    completion = {
      ghost_text = { enabled = true },
      documentation = { auto_show = true },
      auto_brackets = { enabled = true },
    },

    -- Completion sources
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  })
end

return M
