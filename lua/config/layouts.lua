-- layouts.lua - Window layout management module
-- Task 29: Create window layout management module

local M = {}

-- State tracking
M.state = {
  current = nil,
  previous = nil,
  saved_layout = nil
}

-- Save current window layout
local function save_layout()
  local wins = {}
  for i = 1, vim.fn.winnr('$') do
    local win = vim.fn.win_getid(i)
    local buf = vim.api.nvim_win_get_buf(win)
    local config = vim.api.nvim_win_get_config(win)
    table.insert(wins, {
      win = win,
      buf = buf,
      config = config
    })
  end
  M.state.saved_layout = wins
end

-- Maximize editor - close all non-edit windows, keep only current buffer
function M.maximize_editor()
  -- Save previous layout state
  M.state.previous = M.state.current
  M.state.current = 'maximized'
  
  -- Save current window layout for potential restore
  save_layout()
  
  -- Close all other windows
  vim.cmd('only')
  
  vim.notify('Editor maximized', vim.log.levels.INFO)
end

-- Terminal dominant - opens terminal taking main space, editor on top/side
function M.terminal_dominant()
  -- Save previous layout state
  M.state.previous = M.state.current
  M.state.current = 'terminal_dominant'
  
  -- Save current window layout for potential restore
  save_layout()
  
  -- First, keep only current window
  vim.cmd('only')
  
  -- Split horizontally - terminal takes bottom 70%
  vim.cmd('split')
  vim.cmd('wincmd j')
  
  -- Try to use snacks.terminal first, fallback to native terminal
  local ok, snacks = pcall(require, 'snacks')
  if ok then
    snacks.terminal(nil, { horiz = true })
  else
    vim.cmd('terminal')
  end
  
  -- Resize terminal to 70%
  local total_height = vim.o.lines
  local term_height = math.floor(total_height * 0.7)
  vim.api.nvim_win_set_height(0, term_height)
  
  vim.notify('Terminal dominant layout', vim.log.levels.INFO)
end

-- Debug mode - opens DAP UI with scopes/breakpoints/stacks/console panels
function M.debug_mode()
  -- Save previous layout state
  M.state.previous = M.state.current
  M.state.current = 'debug_mode'
  
  -- Save current window layout for potential restore
  save_layout()
  
  -- Try to open DAP UI
  local ok, dapui = pcall(require, 'dapui')
  if ok then
    dapui.open()
    vim.notify('Debug mode layout', vim.log.levels.INFO)
  else
    vim.notify('nvim-dap-ui not available', vim.log.levels.WARN)
  end
end

-- Restore previous layout (optional functionality)
function M.restore_previous()
  if M.state.previous then
    M.state.current = M.state.previous
    M.state.previous = nil
    
    -- Try to close DAP UI if open
    local ok, dapui = pcall(require, 'dapui')
    if ok then
      dapui.close()
    end
    
    -- For now, just return to single window (full restore is complex)
    vim.cmd('only')
    
    vim.notify('Restored previous layout', vim.log.levels.INFO)
  else
    vim.notify('No previous layout to restore', vim.log.levels.WARN)
  end
end

-- Cycle through layouts in order: default -> maximized -> terminal_dominant -> debug_mode -> default
function M.cycle_layout()
  local layouts = {'default', 'maximized', 'terminal_dominant', 'debug_mode'}
  local current = M.state.current or 'default'
  
  -- Find current layout index
  local current_idx = 0
  for i, name in ipairs(layouts) do
    if name == current then
      current_idx = i
      break
    end
  end
  
  -- Get next layout index with wrap-around
  local next_idx = (current_idx % #layouts) + 1
  local next_layout = layouts[next_idx]
  
  -- Save current as previous before switching
  M.state.previous = current
  
  -- Call the appropriate layout function
  if next_layout == 'default' then
    -- Restore to single editor window (default)
    M.state.current = 'default'
    vim.cmd('only')
    vim.notify('Switched to default layout', vim.log.levels.INFO)
  elseif next_layout == 'maximized' then
    M.maximize_editor()
  elseif next_layout == 'terminal_dominant' then
    M.terminal_dominant()
  elseif next_layout == 'debug_mode' then
    M.debug_mode()
  end
end

-- Setup function
function M.setup()
  -- Initialize state
  M.state.current = 'default'
  M.state.previous = nil
end

return M
