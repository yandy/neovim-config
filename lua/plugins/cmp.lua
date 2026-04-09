vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp", version = 'v1.10.2' },
})

vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
    group = vim.api.nvim_create_augroup("SetupCompletion", { clear = true }),
    once = true,
    callback = function()
        require("blink.cmp").setup({
            completion = {
                documentation = {
                    auto_show = true,
                },
            },
            cmdline = { enabled = true, },
            signature = { enabled = true, },
            keymap = { preset = 'default' },
        })
    end
})
