-- keymaps.lua
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<leader>w', ':w<cr>', { desc = 'Save' })
vim.keymap.set('n', '<leader>q', ':q<cr>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>x', ':x<cr>', { desc = 'Save and quit' })

vim.keymap.set('n', 'j', 'v:count == 0 ? "j" : "gj"', { expr = true, desc = 'Move down' })
vim.keymap.set('n', 'k', 'v:count == 0 ? "k" : "gk"', { expr = true, desc = 'Move up' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center' })
vim.keymap.set('n', 'n', 'nzz', { desc = 'Next search and center' })
vim.keymap.set('n', 'N', 'Nzz', { desc = 'Previous search and center' })

vim.keymap.set('n', '<leader>h', ':nohlsearch<cr>', { desc = 'Clear highlights' })

vim.keymap.set('n', '<leader>v', ':vsplit<cr>', { desc = 'Vertical split' })
vim.keymap.set('n', '<leader>s', ':split<cr>', { desc = 'Horizontal split' })

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to down window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to up window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })

-- Buffer navigation
vim.keymap.set('n', '<S-h>', ':bprevious<cr>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<S-l>', ':bnext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bn', ':bnext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', ':bprevious<cr>', { desc = 'Previous buffer' })

-- Edit mappings
vim.keymap.set('n', '<C-s>', ':w<cr>', { desc = 'Save' })
vim.keymap.set('n', '<C-q>', ':q<cr>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>r', ':source ~/.config/nvim/init.lua<cr>', { desc = 'Reload config' })

-- DAP keybindings
vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'DAP continue' })
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, { desc = 'DAP step over' })
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, { desc = 'DAP step into' })
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end, { desc = 'DAP step out' })

vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end, { desc = 'Toggle breakpoint' })
vim.keymap.set('n', '<leader>B', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = 'Set conditional breakpoint' })

vim.keymap.set('n', '<leader>du', function() require('dap').ui.toggle(1) end, { desc = 'Toggle DAP UI' })
vim.keymap.set('n', '<leader>dt', function() require('dap').terminate() end, { desc = 'Terminate DAP' })

vim.keymap.set('n', '<leader>dh', function() require('dap.ui.widgets').hover() end, { desc = 'DAP hover' })
vim.keymap.set('n', '<leader>dp', function() require('dap.ui.widgets').preview() end, { desc = 'DAP preview' })

vim.keymap.set('n', '<leader>dr', function() require('dap').repl.open() end, { desc = 'Open DAP REPL' })

-- Layout switching
vim.keymap.set('n', '<leader>lm', function() require('config.layouts').maximize_editor() end, { desc = 'Maximize editor' })
vim.keymap.set('n', '<leader>lt', function() require('config.layouts').terminal_dominant() end, { desc = 'Terminal dominant layout' })
vim.keymap.set('n', '<leader>ld', function() require('config.layouts').debug_mode() end, { desc = 'Debug mode layout' })
vim.keymap.set('n', '<leader>lr', function() require('config.layouts').restore_previous() end, { desc = 'Restore previous layout' })
