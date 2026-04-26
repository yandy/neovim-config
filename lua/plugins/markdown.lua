vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/OXY2DEV/markview.nvim" },
})

require('nvim-treesitter').install({ 'comment', 'html', 'latex', 'typst', 'yaml' })
-- for code block highlight
require('nvim-treesitter').install({ 'python', 'cpp', 'javascript', 'typescript', 'rust', 'bash' })
require('nvim-treesitter').install({ 'css', 'scss', 'svelte', 'tsx', 'vue' })

require("markview").setup({
    preview = { icon_provider = "devicons" },
    latex = { enable = false }
});

vim.api.nvim_set_keymap("n", "<leader>mp", "<CMD>Markview Toggle<CR>",
    { desc = "toggles preview." });
vim.api.nvim_set_keymap("n", "<leader>ms", "<CMD>Markview splitToggle<CR>",
    { desc = "toggles preview in `splitview`." });
