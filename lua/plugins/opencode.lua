-- opencode.lua - Opencode.nvim AI assistant configuration

local M = {}

M.config = {
  -- Server settings (opencode.nvim uses a local server)
  server = {
    port = 4242, -- Default port for opencode server
    auto_start = true, -- Start server automatically
  },

  -- Context placeholders: @this, @buffer, @diagnostics
  context = {
    -- Enable these placeholders for context injection
    enabled = true,
    -- Placeholder configurations
    placeholders = {
      ["@this"] = {
        enabled = true,
        description = "Current file context",
      },
      ["@buffer"] = {
        enabled = true,
        description = "Full buffer content",
      },
      ["@diagnostics"] = {
        enabled = true,
        description = "LSP diagnostics for current buffer",
      },
    },
  },

  -- Prompt templates for common actions
  prompts = {
    explain = {
      template = "Explain this code:\n```\n@this\n```\nContext:\n@buffer",
      description = "Explain the selected or current code",
    },
    fix = {
      template = "Fix the following code issues:\n```\n@this\n```\n@diagnostics",
      description = "Fix bugs or issues in the code",
    },
    implement = {
      template = "Implement the following feature:\n@this\n\nContext:\n@buffer",
      description = "Implement a new feature or function",
    },
    review = {
      template = "Review this code:\n```\n@this\n```\nContext:\n@buffer\n\nProvide suggestions for improvement.",
      description = "Review code for quality and best practices",
    },
  },

  -- Snacks.nvim integration (opencode uses snacks input/picker)
  snacks = {
    enabled = true, -- Use snacks for input and pickers
  },
}

function M.setup()
  local ok, opencode = pcall(require, "opencode")
  if not ok then
    vim.notify("opencode.nvim not available: " .. tostring(opencode), vim.log.levels.WARN)
    return
  end

  -- Setup opencode with config
  opencode.setup(M.config)

  -- Keymaps for opencode interactions
  -- <C-a>: Ask opencode about current context
  vim.keymap.set({ "n", "x" }, "<C-a>", function()
    opencode.ask()
  end, { desc = "Ask opencode about current context" })

  -- <C-x>: Open action picker
  vim.keymap.set({ "n", "x" }, "<C-x>", function()
    opencode.pick()
  end, { desc = "Open opencode action picker" })

  -- <C-.>: Toggle opencode interface
  vim.keymap.set({ "n", "x" }, "<C-.>", function()
    opencode.toggle()
  end, { desc = "Toggle opencode interface" })

  -- go (operator mode): Add range to context for opencode
  vim.keymap.set({ "n", "x" }, "gO", function()
    opencode.operator()
  end, { desc = "Opencode operator mode" })

  -- Prompt template keymaps (optional quick access)
  vim.keymap.set({ "n", "x" }, "<leader>ox", function()
    opencode.prompt("explain")
  end, { desc = "Opencode explain prompt" })

  vim.keymap.set({ "n", "x" }, "<leader>of", function()
    opencode.prompt("fix")
  end, { desc = "Opencode fix prompt" })

  vim.keymap.set({ "n", "x" }, "<leader>oi", function()
    opencode.prompt("implement")
  end, { desc = "Opencode implement prompt" })

  vim.keymap.set({ "n", "x" }, "<leader>or", function()
    opencode.prompt("review")
  end, { desc = "Opencode review prompt" })
end

return M