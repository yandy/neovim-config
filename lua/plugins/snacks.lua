vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim" },
})

require("snacks").setup({
    bigfile = {},
    picker = {},
    explorer = {},
    input = {},
    terminal = {},
    lazygit = {},
    image = {},
    styles = {
        terminal = {
            bo = {
                filetype = "snacks_terminal",
            },
            wo = {},
            stack = true,
            keys = {
                q = "hide",
                gf = function(self)
                    local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
                    if f == "" then
                        Snacks.notify.warn("No file under cursor")
                    else
                        self:hide()
                        vim.schedule(function()
                            vim.cmd("e " .. f)
                        end)
                    end
                end,
            },
        },
    },
})

vim.keymap.set("n", "<leader>e", Snacks.explorer.open, { desc = "File Explorer" })

vim.keymap.set("n", "<leader><space>", Snacks.picker.smart, { desc = "Find content" })
vim.keymap.set("n", "<leader>ff", Snacks.picker.files, { desc = "Smart find files" })
vim.keymap.set("n", "<leader>fr", Snacks.picker.recent, { desc = "Find recent files" })
vim.keymap.set("n", "<leader>fb", Snacks.picker.buffers, { desc = "Find content" })
vim.keymap.set("n", "<leader>fg", Snacks.picker.grep, { desc = "Find content" })
vim.keymap.set("n", "<leader>fh", Snacks.picker.help, { desc = "Find content" })

vim.keymap.set("n", "<leader>tt", function() Snacks.terminal() end, { desc = "Open Terminal" })
vim.keymap.set("t", "<leader>tn", [[<C-\><C-n>]], { desc = "Return to Normal Terminal" })

vim.keymap.set("n", "<leader>lg", function() Snacks.lazygit() end, { desc = "Toggle lazygit" })
