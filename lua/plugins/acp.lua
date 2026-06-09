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
        width = "40%",
    }
}

local agentic = require("agentic")
local esc_timer = vim.uv.new_timer()

agentic.setup(opts)

vim.keymap.set({ "n", "v", "i" }, "<c-.>", function() agentic.toggle() end, { desc = 'toggle agentic chat' })
vim.keymap.set({ "n", "v" }, "<c-'>", function() agentic.add_selection_or_file_to_context() end,
    { desc = 'add file or selection to agentic context' })
vim.keymap.set({ "n", "v" }, "<c-/>", function() agentic.add_buffer_diagnostics() end,
    { desc = 'add all buffer diagnostics to agentic' })

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("AgenticChatKeymap", { clear = true }),
    pattern = { "Agentic*" },
    callback = function(event)
        vim.keymap.set({ "n", "v" }, "<localleader>r", function() agentic.rotate_layout({ "right", "bottom" }) end,
            { buffer = event.buf, desc = 'rotate agentic chat layout' })
        vim.keymap.set({ "n", "v" }, "<localleader>n", function() agentic.new_session() end,
            { buffer = event.buf, desc = 'new agentic session' })
        vim.keymap.set({ "n", "v" }, "<localleader>l", function() agentic.restore_session() end,
            { buffer = event.buf, desc = 'list agentic session for restore' })
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
            { expr = true, noremap = true, buffer = event.buf, desc = 'double esc to interrupt generation' })
    end
})
