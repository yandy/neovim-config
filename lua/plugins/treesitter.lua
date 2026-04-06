local M = {}

local languages = {
  'lua',
  'python',
  'javascript',
  'typescript',
  'c',
  'cpp',
}

local function setup_treesitter()
  for _, lang in ipairs(languages) do
    pcall(vim.treesitter.language.add, lang)
  end
end

function M.setup()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = table.concat(languages, ','),
    callback = function(args)
      vim.treesitter.start(args.buf)
    end,
  })

  vim.defer_fn(setup_treesitter, 0)

  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  vim.opt.foldlevel = 99
end

return M
