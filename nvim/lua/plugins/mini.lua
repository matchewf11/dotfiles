-- look at all
-- https://github.com/nvim-mini/mini.nvim/blob/main/doc/mini-nvim.txt
-- also the general ones
-- read more about mini ecosystem
-- read about plugins that i have

return {
  'nvim-mini/mini.nvim',
  version = false,
  config = function()
    require('mini.statusline').setup {}
    require('mini.icons').setup {}
    require('mini.pairs').setup {}
    require('mini.files').setup {} -- keep this?

    local miniclue = require 'mini.clue'
    miniclue.setup {
      triggers = {
        -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },
        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },
        -- `g` key
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },
        -- Marks
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },
        -- Registers
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },
        -- Window commands
        { mode = 'n', keys = '<C-w>' },
        -- `z` key
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
      },

      clues = {
        { mode = 'n', keys = '<leader>s', desc = '[s]earch' },
        { mode = 'n', keys = '<leader>g', desc = '[g]it' },
        -- Enhance this by adding descriptions for <Leader> mapping groups
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
      },
    }
  end,
}

-- return {
-- 'stevearc/oil.nvim',
-- opts = {
--   delete_to_trash = true,
--   watch_for_changes = true,
--   view_options = {
--     show_hidden = true,
--     is_always_hidden = function(name, _)
--       return name == '..'
--     end,
--   },
-- },
-- dependencies = { 'nvim-mini/mini.nvim' },
-- }

-- return {
--   'folke/which-key.nvim',
--   event = 'VeryLazy',
--   opts = {
--     delay = 0,
--     spec = {
--       { '<leader>s', group = '[s]earch' },
--       { '<leader>g', group = '[g]it' },
--     },
--   },
-- }

-- get rid of status in left (use vim default)
-- get rid of mode on bottom line?

-- vim.o.laststatus = 3
--
-- function _G.statusline()
--   ---@generic T, R
--   ---@param tbl T[]
--   ---@param fn fun(acc: R, v: T): R
--   ---@param init R
--   ---@return R
--   local function tbl_reduce(tbl, fn, init)
--     local acc = init
--     for _, v in ipairs(tbl) do
--       acc = fn(acc, v)
--     end
--     return acc
--   end
--
--   local severity = vim.diagnostic.severity
--
--   local counts = tbl_reduce(vim.diagnostic.get(0), function(acc, d)
--     acc[d.severity] = acc[d.severity] + 1
--     return acc
--   end, { 0, 0, 0, 0 })
--
--   return ' '
--     .. table.concat(
--       vim.tbl_filter(function(s)
--         return s ~= ''
--       end, {
--         -- file name
--         '%f',
--         -- git updates
--         (function()
--           if vim.b.gitsigns_head and vim.b.gitsigns_head ~= '' then
--             local git_section = vim.b.gitsigns_head
--             if vim.b.gitsigns_status and vim.b.gitsigns_status ~= '' then
--               git_section = git_section .. ' ' .. vim.b.gitsigns_status
--             end
--             return git_section
--           elseif vim.b.gitsigns_status and vim.b.gitsigns_status ~= '' then
--             return vim.b.gitsigns_status
--           end
--         end)(),
--         -- middle
--         '%=',
--         -- Warnings
--         table.concat(
--           vim.tbl_filter(
--             function(v)
--               return v
--             end,
--             vim.tbl_map(function(sev_tbl)
--               if counts[sev_tbl[1]] > 0 then
--                 return sev_tbl[2] .. ':' .. counts[sev_tbl[1]]
--               end
--             end, {
--               { severity.ERROR, 'E' },
--               { severity.WARN, 'W' },
--               { severity.INFO, 'I' },
--               { severity.HINT, 'H' },
--             })
--           ),
--           ' '
--         ),
--         -- file type
--         '[%M%R%H%W%Y]%q',
--         -- line numbers
--         '%l/%L:%c',
--       }),
--       ' | '
--     )
--     .. ' '
-- end
--
-- vim.o.statusline = '%!v:lua.statusline()'
