vim.pack.add({
    { src = "https://github.com/OXY2DEV/markview.nvim" },
})

vim.api.nvim_set_keymap("n", "<leader>mp", "<CMD>Markview Toggle<CR>",
    { desc = "toggles preview." });
vim.api.nvim_set_keymap("n", "<leader>ms", "<CMD>Markview splitToggle<CR>",
    { desc = "toggles preview in `splitview`." });
