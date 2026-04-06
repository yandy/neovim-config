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
