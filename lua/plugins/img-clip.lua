vim.pack.add({
    { src = "https://github.com/hakonharnes/img-clip.nvim" },
})

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("SetupImgClip", { clear = true }),
    pattern = { "typst", "tex", "markdown" },
    once = true,
    callback = function()
        require("img-clip").setup({
            default = {
                copy_images = true,
                process_cmd = "convert - -quality 85 -", -- compress the image with 85% quality
            }
        })
        vim.keymap.set("n", "<leader>P", "<cmd>PasteImage<cr>", { desc = "Paste image from system clipboard" })
    end,
})
