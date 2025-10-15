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
  end,
}

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
