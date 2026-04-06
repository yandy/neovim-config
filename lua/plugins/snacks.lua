-- snacks.lua - Snacks.nvim configuration
-- Tasks 19-22: explorer, terminal, picker, lazygit

local M = {}

-- Set Snacks namespace
vim.g.snacks_namespace = "snacks"

M.config = {
  -- Enable animations
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

  -- Explorer configuration (Task 19)
  explorer = {
    enabled = true,
    -- File operations
    file = {
      expand = true,
      open = "edit",
      new = "edit",
      rename = "edit",
      delete = "trash",
    },
    tree = {
      indent = 2,
      hide_root = false,
      git = {
        enabled = true,
        untracked = "dim",
        ignored = "none",
        deleted = "dim",
        renamed = "dim",
        staged = "bold",
        unstaged = "none",
      },
    },
  },

  -- Terminal configuration (Task 20)
  terminal = {
    enabled = true,
    float = {
      relative = "editor",
      row = 0.1,
      col = 0.5,
      width = 0.8,
      height = 0.8,
    },
    horiz = {
      size = 20,
    },
    vert = {
      size = 40,
    },
  },

  -- Picker configuration (Task 21)
  picker = {
    enabled = true,
    -- Picker sources
    sources = {
      files = {
        find = {
          use_git = true,
        },
      },
    },
  },

  -- LazyGit configuration (Task 22)
  lazygit = {
    enabled = true,
    -- Use floating window
    float = {
      relative = "editor",
    },
  },
}

function M.setup()
  local snacks = require("snacks")

  snacks.setup(M.config)

  -- Explorer keymap: <leader>e
  vim.keymap.set("n", "<leader>e", function()
    snacks.explorer()
  end, { desc = "Toggle explorer" })

  -- Terminal keymaps (Task 20)
  vim.keymap.set("n", "<leader>tt", function()
    snacks.terminal()
  end, { desc = "Terminal float" })

  vim.keymap.set("n", "<leader>th", function()
    snacks.terminal(nil, { horiz = snacks.terminal.split.horiz })
  end, { desc = "Terminal horizontal" })

  vim.keymap.set("n", "<leader>tv", function()
    snacks.terminal(nil, { vert = snacks.terminal.split.vert })
  end, { desc = "Terminal vertical" })

  -- Picker keymaps (Task 21)
  vim.keymap.set("n", "<leader>ff", function()
    snacks.picker.files()
  end, { desc = "Find files" })

  vim.keymap.set("n", "<leader>fg", function()
    snacks.picker.grep()
  end, { desc = "Grep" })

  vim.keymap.set("n", "<leader>fb", function()
    snacks.picker.buffers()
  end, { desc = "Find buffers" })

  vim.keymap.set("n", "<leader>fh", function()
    snacks.picker.help()
  end, { desc = "Find help" })

  -- LazyGit keymap: <leader>gg
  vim.keymap.set("n", "<leader>gg", function()
    snacks.lazygit()
  end, { desc = "Toggle lazygit" })
end

return M
