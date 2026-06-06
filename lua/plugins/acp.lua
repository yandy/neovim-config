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
            },
            default_thought_level = "max"
        }
    },
    windows = {
        width = "60%",
    }
}

local agentic = require("agentic")

agentic.setup(opts)

vim.keymap.set({ "n", "v", "i" }, "<c-.>", function() agentic.toggle() end, { desc = 'toggle agentic chat' })
vim.keymap.set({ "n", "v" }, "<c-'>", function() agentic.add_selection_or_file_to_context() end,
    { desc = 'add file or selection to agentic context' })
vim.keymap.set({ "n", "v" }, "<localleader>n", function() agentic.new_session() end,
    { desc = 'new agentic session' })
vim.keymap.set({ "n", "v" }, "<localleader>l", function() agentic.restore_session() end,
    { desc = 'list agentic session for restore' })

local esc_timer = vim.uv.new_timer()
vim.keymap.set(
    "n", "<esc>", function()
        if esc_timer:is_active() then
            esc_timer:stop()
            agentic.stop_generation()
        else
            esc_timer:start(200, 0, function() end)
            return "<esc>"
        end
    end,
    { expr = true, noremap = true, desc = 'double esc to interrupt generation' })
