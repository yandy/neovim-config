vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim" },
})

require("snacks").setup({
    bigfile = {},
    picker = {
        ui_select = true,
        matcher = { frecency = true, cwd_bonus = true, history_bonus = true },
        formatters = { icon_width = 3 },
        --- for opencode
        actions = {
            opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
        },
        win = {
            input = {
                keys = {
                    ["<c-e>t"] = { "tab", mode = { "i", "n" } },
                    ["<c-e>s"] = { "edit_split", mode = { "i", "n" } },
                    ["<c-e>v"] = { "edit_vsplit", mode = { "i", "n" } },
                    --- for opencode
                    ["<a-o>"] = { "opencode_send", mode = { "n", "i" } },
                }
            }
        }
    },
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

vim.keymap.set("n", "<leader>e", function() Snacks.explorer.open() end, { desc = "File Explorer" })

vim.keymap.set("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Find content" })
vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Smart find files" })
vim.keymap.set("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Find recent files" })
vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Find content" })
vim.keymap.set("n", "<leader>fg", function() Snacks.picker.grep() end, { desc = "Find content" })
vim.keymap.set("n", "<leader>fh", function() Snacks.picker.help() end, { desc = "Find content" })

vim.keymap.set({ "n", "t" }, "<c-`>", function() Snacks.terminal.toggle() end, { desc = "Toggle Terminal" })

vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "References", nowait = true })
vim.keymap.set("n", "gi", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
vim.keymap.set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
vim.keymap.set("n", "<leader>ls", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Current Buffer Symbols" })
vim.keymap.set("n", "<leader>lS", function() Snacks.picker.lsp_workspace_symbols() end,
    { desc = "LSP Workspace Symbols" })

vim.keymap.set("n", "<leader>ld", function() Snacks.picker.diagnostics() end, { desc = "Document Diagnostics" })
vim.keymap.set("n", "<leader>lD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Workspace Diagnostics" })

vim.keymap.set("n", "<leader>lg", function() Snacks.lazygit() end, { desc = "Toggle lazygit" })
