vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
})

require('nvim-treesitter').install({ 'comment', 'html', 'latex', 'typst', 'yaml' })
-- for code block highlight
require('nvim-treesitter').install({ 'python', 'cpp', 'javascript', 'typescript', 'rust', 'bash' })
require('nvim-treesitter').install({ 'css', 'scss', 'svelte', 'tsx', 'vue' })

require('render-markdown').setup({
    preset = 'obsidian',
    anti_conceal = { enabled = false },
    file_types = { "markdown", "md", "AgenticChat" },
    completions = {
        blink = { enabled = true },
        lsp = { enabled = true }
    },
    code = {
        border = 'thick',
    },
    latex = { enabled = false }
})

vim.api.nvim_set_keymap("n", "<leader>mt", "<CMD>RenderMarkdown buf_toggle<CR>",
    { desc = "toggles markdown render." });
vim.api.nvim_set_keymap("n", "<leader>mp", "<CMD>RenderMarkdown preview<CR>",
    { desc = "preview markdown by side" });
