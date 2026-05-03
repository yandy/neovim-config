vim.pack.add({
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/owallb/mason-auto-install.nvim" }
})
require("mason").setup()
require('mason-auto-install').setup({
    packages = {
        "ast-grep",
        { "clangd", version = "22.1.0" },
        "basedpyright",
        "typescript-language-server",
        "biome",
        "tailwindcss-language-server",
        "marksman",
        "rust-analyzer",
        "bash-language-server",
        "lua-language-server",
        "debugpy",
        "js-debug-adapter"
    },
})
require("mason-lspconfig").setup()
