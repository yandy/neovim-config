-- dap.lua - DAP core configuration
-- Wave 3 Task 13, 15

local M = {}

-- Configure DAP breakpoint signs and highlights
M.config_signs = function()
  local dap = require("dap")

  local signs = {
    DapBreakpoint = { text = "●", texthl = "DiagnosticSignError", linehl = "", numhl = "" },
    DapBreakpointCondition = { text = "◆", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" },
    DapBreakpointRejected = { text = "✗", texthl = "DiagnosticSignHint", linehl = "", numhl = "" },
    DapLogPoint = { text = "◆", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" },
    DapStopped = { text = "→", texthl = "DiagnosticSignInfo", linehl = "CursorLine", numhl = "" },
  }

  for name, sign in pairs(signs) do
    vim.fn.sign_define(name, sign)
  end
end

-- Configure DAP log level
M.config_log = function()
  local dap = require("dap")
  dap.set_log_level("INFO")
end

-- Configure DAP event listeners base framework
M.config_listeners = function()
  local dap = require("dap")

  dap.listeners.after.event_initialized["dap_config"] = function()
    -- Base event listener for initialized event
  end

  dap.listeners.after.event_terminated["dap_config"] = function()
    -- Base event listener for terminated event
  end

  dap.listeners.after.event_exited["dap_config"] = function()
    -- Base event listener for exited event
  end

  dap.listeners.after.event_stopped["dap_config"] = function()
    -- Base event listener for stopped event
  end
end

-- Configure Python debug adapter (debugpy via mason)
M.config_python = function()
  local ok, dap_python = pcall(require, "dap-python")
  if not ok then
    return
  end

  -- Get mason debugpy path dynamically (avoid hardcoded paths)
  local mason_pkg_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy"

  -- Setup dap-python with mason-installed debugpy
  pcall(dap_python.setup, mason_pkg_path .. "/debugpy")

  dap.configurations.python = {
    {
      type = "python",
      request = "launch",
      name = "Python: Current File",
      program = "${file}",
      pythonPath = function()
        return vim.fn.exepath("python3") or "python3"
      end,
    },
    {
      type = "python",
      request = "launch",
      name = "Python: Current File (with args)",
      program = "${file}",
      args = function()
        local arg_input = vim.fn.input("Arguments: ")
        return vim.split(arg_input, " +", { plain = true })
      end,
      pythonPath = function()
        return vim.fn.exepath("python3") or "python3"
      end,
    },
    {
      type = "python",
      request = "launch",
      name = "Python: Module",
      module = function()
        return vim.fn.input("Module name: ")
      end,
      pythonPath = function()
        return vim.fn.exepath("python3") or "python3"
      end,
    },
    {
      type = "python",
      request = "launch",
      name = "Python: Pytest",
      module = "pytest",
      args = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local filepath = vim.api.nvim_buf_get_name(bufnr)
        if filepath and (filepath:match("test_.*%.py$") or filepath:match(".*_test%.py$")) then
          return { filepath }
        end
        return {}
      end,
      justMyCode = false,
      pythonPath = function()
        return vim.fn.exepath("python3") or "python3"
      end,
    },
    {
      type = "python",
      request = "attach",
      name = "Python: Attach to Process",
      connect = function()
        local host = vim.fn.input("Host: ", "localhost")
        local port = tonumber(vim.fn.input("Port: ", "5678")) or 5678
        return { host = host, port = port }
      end,
      pythonPath = function()
        return vim.fn.exepath("python3") or "python3"
      end,
    },
  }
end

-- Configure codelldb adapter for C/C++ debugging
M.config_codelldb = function()
  local dap = require("dap")

  -- codelldb path from mason installation
  local codelldb_path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"

  dap.adapters.codelldb = function(callback, conf)
    local adapter = {
      type = "server",
      port = conf.port or 13000,
      executable = {
        command = codelldb_path,
        args = { "--port", tostring(conf.port or 13000) },
      },
    }
    callback(adapter)
  end

  -- C++ launch configuration
  dap.configurations.cpp = {
    {
      name = "Launch",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
      environment = {},
      externalConsole = false,
      preLaunchTask = "",
    },
    {
      name = "Attach to Process",
      type = "codelldb",
      request = "attach",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      pid = function()
        return tonumber(vim.fn.input("Process ID: "))
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }

  -- C uses same configurations as C++
  dap.configurations.c = dap.configurations.cpp

  -- Also support h/hpp files as C++
  dap.configurations.h = dap.configurations.cpp
  dap.configurations.hpp = dap.configurations.cpp
end

-- Configure JavaScript/TypeScript debugging (js-debug via mason)
M.config_js_debug = function()
  local dap = require("dap")

  -- js-debug adapter configuration
  dap.adapters.jsdebug = {
    type = "executable",
    command = "node",
    args = { vim.fn.stdpath("data") .. "/mason/packages/js-debug/src/dapDebugServer.js" },
  }

  -- Node.js debug configurations
  dap.configurations.javascript = {
    {
      type = "node2",
      request = "launch",
      name = "Node.js: Launch Program",
      program = "${workspaceFolder}/${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "node2",
      request = "attach",
      name = "Node.js: Attach",
      port = 9229,
      restart = true,
      skipFiles = { "<node_internals>/**" },
    },
  }

  -- TypeScript debug configurations
  dap.configurations.typescript = {
    {
      type = "node2",
      request = "launch",
      name = "TypeScript: Launch Program",
      runtimeExecutable = "npx",
      runtimeArgs = { "ts-node", "${file}" },
      cwd = "${workspaceFolder}",
      skipFiles = { "<node_internals>/**" },
    },
    {
      type = "jsdebug",
      request = "launch",
      name = "TypeScript: Debug with js-debug",
      program = "${workspaceFolder}/${file}",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      skipFiles = { "<node_internals>/**" },
    },
  }

  -- React debug configurations (Chrome/Edge)
  dap.configurations.typescriptreact = {
    {
      type = "jsdebug",
      request = "launch",
      name = "React: Debug Chrome",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      sourceMaps = true,
      skipFiles = { "<node_internals>/**" },
      runtimeExecutable = "google-chrome",
    },
    {
      type = "jsdebug",
      request = "launch",
      name = "React: Debug Edge",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      sourceMaps = true,
      skipFiles = { "<node_internals>/**" },
      runtimeExecutable = "msedge",
    },
  }

  dap.configurations.javascriptreact = dap.configurations.typescriptreact
end

-- Configure nvim-dap-ui
M.config_dapui = function()
  local ok, dapui = pcall(require, "dapui")
  if not ok then
    vim.notify("nvim-dap-ui not found", vim.log.levels.WARN)
    return
  end

  dapui.setup({
    -- UI 布局配置
    layouts = {
      {
        elements = {
          { id = "scopes", size = 0.25 },
          { id = "breakpoints", size = 0.25 },
          { id = "stacks", size = 0.25 },
          { id = "watches", size = 0.25 },
        },
        position = "left",
        size = 40,
      },
      {
        elements = {
          { id = "repl", size = 0.5 },
          { id = "console", size = 0.5 },
        },
        position = "bottom",
        size = 10,
      },
    },
    -- 图标配置
    icons = {
      expanded = "▾",
      collapsed = "▸",
      current_frame = "→",
    },
    -- 控制栏配置
    controls = {
      enabled = true,
      element = "repl",
      icons = {
        pause = "⏸",
        play = "▶",
        step_into = "↓",
        step_over = "↷",
        step_out = "↑",
        step_back = "↶",
        run_last = "↻",
        terminate = "⏹",
        disconnect = "⏏",
      },
    },
    -- 浮动窗口配置
    floating = {
      border = "rounded",
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
    -- 窗口缩进配置
    windows = { indent = 1 },
    -- 渲染配置
    render = {
      max_value_lines = 100,
    },
  })
end

-- Setup function to be called from init.lua
function M.setup()
  M.config_signs()
  M.config_log()
  M.config_listeners()
  M.config_python()
  M.config_codelldb()
  M.config_js_debug()
  M.config_dapui()
end

return M
