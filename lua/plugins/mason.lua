vim.pack.add({
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/owallb/mason-auto-install.nvim" }
})
require("mason").setup()
require('mason-auto-install').setup({
    packages = {
        { "clangd", version = "22.1.0" },
        "basedpyright",
        "typescript-language-server",
        "rust-analyzer",
        "lua-language-server",
        "bash-language-server",
        "tailwindcss-language-server",
        "marksman",
        "debugpy",
        "js-debug-adapter"
    },
})
require("mason-lspconfig").setup()
