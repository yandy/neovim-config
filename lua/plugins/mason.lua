-- mason.nvim configuration
-- Wave 2 Task 6

local M = {}

M.config = function()
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")
  local mason_tool_installer = require("mason-tool-installer")

  mason.setup({
    install_root_dir = vim.fn.stdpath("data") .. "/mason",
    ui = {
      check_outdated_packages_on_open = true,
      border = "rounded",
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
    install_endpoint = {
      shell = vim.fn.executable("curl") > 0 and "curl" or "wget",
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
  })

  mason_lspconfig.setup({
    ensure_installed = { "pyright", "tsserver", "clangd" },
    automatic_installation = true,
  })

  mason_tool_installer.setup({
    ensure_installed = {
      "pyright",
      "tsserver",
      "clangd",
      "js-debug",
      "prettier",
      "black",
      "ruff",
      "eslint_d",
    },
    automatic_updates = true,
    run_on_start = true,
  })
end

function M.setup()
  M.config()
end

return M
