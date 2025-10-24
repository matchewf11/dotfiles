-- finish this
-- README
-- Docs
-- Write down :h's
-- look at telescope for other pickers

local mini_pick = require 'mini.pick'

mini_pick.setup {
  --[[
  caret_left/caret_right = '<Left/Right>'
  move_up/move_down/move_start = '<C-p/n/g>' -- change to j/k later
  stop  = '<Esc>'
  choose  = '<CR>',
  choose_in_split  = '<C-s>',
  choose_in_tabpage  = '<C-t>',
  choose_in_vsplit  = '<C-v>',
  choose_marked  = '<M-CR>',
  delete_char  = '<BS>',
  delete_char_right  = '<Del>',
  delete_left  = '<C-u>',
  delete_word  = '<C-w>',
  mark  = '<C-x>',
  mark_all  = '<C-a>',
  paste  = '<C-r>',
  refine  = '<C-Space>',
  refine_marked  = '<M-Space>',
  scroll_down  = '<C-f>',
  scroll_left  = '<C-h>',
  scroll_right  = '<C-l>',
  scroll_up  = '<C-b>',
  toggle_info  = '<S-Tab>',
  toggle_preview  = '<Tab>',
  -- custom ones?
]]
  options = {
    content_from_bottom = true,
    use_cache = true,
  },
  window = {
    prompt_caret = '█',
  },
}

mini_pick.registry.blines = function()
  local buf_lines = {}
  for i, v in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
    table.insert(buf_lines, string.format('%d| %s', i, v))
  end
  mini_pick.start {
    source = {
      items = buf_lines,
      name = 'Buffer Lines',
      choose = function(chosen)
        if chosen then
          local i = tonumber(chosen:match '^(%d+)|')
          vim.schedule(function()
            vim.api.nvim_win_set_cursor(0, { i, 0 })
          end)
        end
      end,
    },
  }
end

mini_pick.registry.oldfiles = function()
  mini_pick.start {
    source = {
      items = vim.v.oldfiles,
      name = 'Oldfiles',
      choose = function(file)
        if not file then
          return
        end
        vim.schedule(function()
          vim.cmd('e ' .. file)
        end)
      end,
    },
  }
end

local function search_map(keymap, cmd, desc)
  vim.keymap.set('n', string.format('<leader>s%s', keymap), string.format('<Cmd>Pick %s<CR>', cmd), { desc = desc })
end

-- Example `:Pick files tool='git'`
-- * fuzzy, ' exact, $ end, ^ start
search_map('f', 'files', 'Files')
search_map('b', 'buffers', 'Buffers')
search_map('l', 'blines', 'Buffer Lines')
search_map('r', 'resume', 'Resume')
search_map('h', 'help', 'Help')
search_map('G', 'grep', 'Grep')
search_map('g', 'grep_live', 'Grep_live')
search_map('o', 'oldfiles', 'Oldfiles')
search_map('c', 'cli', 'Cli')
