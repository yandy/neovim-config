vim.pack.add({
    { src = "https://github.com/catppuccin/nvim",            name = "catppuccin" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

require("catppuccin").setup({
    integrations = {
        snacks = {
            enabled = true,
        }
    }
})

vim.cmd.colorscheme "catppuccin-nvim"
