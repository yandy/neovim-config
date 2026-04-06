-- lsp.lua - LSP core configuration
-- Wave 2 Task 7, 8

local M = {}

-- Configure pyright language server
M.config_pyright = function()
  local lspconfig = require("lspconfig")

  lspconfig.pyright.setup({
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    settings = {
      python = {
        pythonPath = "",
        venvPath = "",
        pythonAnalysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          typeCheckingMode = "basic",
          reportMissingTypeStubs = false,
        },
      },
    },
  })
end

-- Configure tsserver (TypeScript/JavaScript)
M.config_tsserver = function()
  local lspconfig = require("lspconfig")

  lspconfig.tsserver.setup({
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    settings = {
      typescript = {
        -- Enable strict type checking
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
      javascript = {
        -- Enable strict type checking for JS
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  })
end

-- Configure diagnostic symbols
M.config_diagnostics = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
    { name = "DiagnosticSignHint", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = {
      spacing = 4,
      source = "if_many",
      prefix = "●",
    },
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)
end

-- Configure LSP formatting
M.config_formatting = function(client)
  -- Disable formatting if we want to use null-ls or other formatters later
  -- client.server_capabilities.documentFormattingProvider = false
  -- client.server_capabilities.documentRangeFormattingProvider = false
end

-- Configure LSP hover and signature help
M.config_handlers = function()
  local hover_config = { border = "rounded" }
  vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
    return vim.lsp.handlers.hover(err, result, ctx, vim.tbl_deep_extend("force", config or {}, hover_config))
  end

  local signature_config = { border = "rounded" }
  vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
    return vim.lsp.handlers.signature_help(err, result, ctx, vim.tbl_deep_extend("force", config or {}, signature_config))
  end
end

-- Configure LSP autocommands
M.config_autocommands = function(client, bufnr)
  -- Format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormat", { clear = true }),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end

  -- Show diagnostic float when cursor holds
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "always",
        prefix = " ",
        scope = "cursor",
      }
      vim.diagnostic.open_float(nil, opts)
    end,
  })
end

-- Common on_attach function for all LSP clients
M.on_attach = function(client, bufnr)
  M.config_formatting(client)
  M.config_autocommands(client, bufnr)

  -- LSP keybindings (buffer-local)
  local bufmap = function(mode, lhs, rhs, desc)
    local opts = { buffer = bufnr, desc = desc }
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- Code navigation
  bufmap('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
  bufmap('n', 'gr', vim.lsp.buf.references, 'Show references')
  bufmap('n', 'gI', vim.lsp.buf.implementation, 'Go to implementation')
  bufmap('n', 'gy', vim.lsp.buf.type_definition, 'Go to type definition')

  -- Documentation
  bufmap('n', 'K', vim.lsp.buf.hover, 'Show hover documentation')
  bufmap('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')

  -- Code actions
  bufmap('n', '<leader>ca', vim.lsp.buf.code_action, 'Code action')
  bufmap({ 'n', 'v' }, '<leader>f', function()
    vim.lsp.buf.format({ bufnr = bufnr })
  end, 'Format code')

  -- Diagnostics navigation
  bufmap('n', '[d', function()
    vim.diagnostic.goto_prev({ float = false })
  end, 'Previous diagnostic')
  bufmap('n', ']d', function()
    vim.diagnostic.goto_next({ float = false })
  end, 'Next diagnostic')
  bufmap('n', '<leader>q', vim.diagnostic.setloclist, 'Diagnostics list')
end

-- Common capabilities for all LSP clients
M.capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Configure clangd language server (C/C++)
M.config_clangd = function()
  local lspconfig = require("lspconfig")

  lspconfig.clangd.setup({
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "h", "hpp", "objc", "objcpp" },
    root_dir = function(fname)
      return lspconfig.util.root_pattern(
        ".clangd",
        ".clang-tidy",
        ".clang-format",
        "compile_commands.json",
        "compile_flags.txt",
        "configure.ac",
        ".git"
      )(fname)
    end,
    -- clangd-specific options
    offsetEncoding = { "utf-8", "utf-16" },
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
  })
end

-- Setup function to be called from init.lua
function M.setup()
  M.config_diagnostics()
  M.config_handlers()
  M.config_pyright()
  M.config_tsserver()
  M.config_clangd()
end

return M
