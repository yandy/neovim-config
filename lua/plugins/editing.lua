local M = {}

function M.setup()
  require('nvim-autopairs').setup({
    check_ts = true,
    ts_config = {
      lua = { 'string' },
      javascript = { 'template_string' },
      go = { 'string' },
    },
  })

  require('ibl').setup({
    indent = {
      char = '│',
    },
    scope = {
      enabled = true,
      highlight = 'CursorLineNr',
    },
    exclude = {
      filetypes = {
        'help',
        'dashboard',
        'lazy',
        'mason',
        'notify',
      },
    },
  })

  require('trim').setup({
    highlight = false,
    patterns = {
      [[%s/\m$/]],
      [[%s/\m\s+$/]],
    },
    exclude = {
      'markdown',
    },
  })
end

return M