vim.pack.add({
    { src = "https://github.com/carlos-algms/agentic.nvim" },
})

--- @type agentic.PartialUserConfig
opts = {
    provider = "opencode-acp",
    acp_providers = {
        ["opencode-acp"] = {
            env = {
                OPENCODE_ENABLE_EXA = 1,
                OPENCODE_EXPERIMENTAL_LSP_TOOL = 1
            }
        }
    },
    windows = {
        width = "60%",
    }
}

local agentic = require("agentic")

agentic.setup(opts)

vim.keymap.set({ "n", "t", "v", "i" }, "<c-.>", function() agentic.toggle() end, { desc = 'toggle Agentic Chat' })
vim.keymap.set({ "n", }, "<esc>", function() agentic.stop_generation() end,
    { desc = 'interrupt generation' })
vim.keymap.set({ "n", "v" }, "<c-'>", function() agentic.add_selection_or_file_to_context() end,
    { desc = 'Add file or selection to Agentic to Context' })
vim.keymap.set({ "n", "v" }, "<localleader>n", function() agentic.new_session() end,
    { desc = 'New Agentic Session' })
vim.keymap.set({ "n", "v" }, "<localleader>l", function() agentic.restore_session() end,
    { desc = 'Agentic Restore session' })
