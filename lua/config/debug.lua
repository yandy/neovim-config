local dap, dapui = require("dap"), require("dapui")


dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

require("nvim-dap-virtual-text").setup()
dapui.setup()

-- language configs
require("dap-python").setup("uv")
dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-dap', -- adjust as needed, must be absolute path
    name = 'lldb'
}

dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},

        -- 💀
        -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
        --
        --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        --
        -- Otherwise you might get the following error:
        --
        --    Error on launch: Failed to attach to the target process
        --
        -- But you should be aware of the implications:
        -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
        -- runInTerminal = false,
    },
}

-- Custom breakpoint icons
vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = 'DapBreakpoint' })
vim.fn.sign_define(
    'DapBreakpointCondition',
    { text = '', texthl = 'DapBreakpointCondition', linehl = 'DapBreakpointCondition', numhl = 'DapBreakpointCondition' }
)
vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

-- keymaps)
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'DAP: Breakpoint' })
vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, { desc = 'DAP: Breakpoint' })
vim.keymap.set('n', '<leader>dD', dap.clear_breakpoints, { desc = 'DAP: Clear Breakpoints' })
vim.keymap.set('n', '<S-F9>', dap.clear_breakpoints, { desc = 'DAP: Clear Breakpoints' })

vim.keymap.set('n', '<leader>ds', dap.continue, { desc = ' Start/Continue' })
vim.keymap.set('n', '<F5>', dap.continue, { desc = ' Start/Continue' })
vim.keymap.set('n', '<leader>do', dap.step_over, { desc = ' Step over' })
vim.keymap.set('n', '<F10>', dap.step_over, { desc = ' Step over' })
vim.keymap.set('n', '<leader>di', dap.step_into, { desc = ' Step into' })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = ' Step into' })
vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = ' Step out' })
vim.keymap.set('n', '<S-F11>', dap.step_out, { desc = ' Step out' })
vim.keymap.set('n', '<leader>dQ', dap.terminate, { desc = ' Terminate session' })
vim.keymap.set('n', '<S-F5>', dap.terminate, { desc = ' Terminate session' })

vim.keymap.set('n', '<leader>dB', function()
    local input = vim.fn.input 'Condition for breakpoint:'
    dap.set_breakpoint(input)
end, { desc = 'DAP: Conditional Breakpoint' })
