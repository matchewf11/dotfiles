return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    signs = {
      add = { text = '┃' },
      change = { text = '┃' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
      --     opts = {
      --       signs = {
      --         add = { text = '+' },
      --         change = { text = '~' },
      --         delete = { text = '_' },
      --         topdelete = { text = '‾' },
      --         changedelete = { text = '~' },
      --       },
      --     },
    },
    signs_staged = {
      add = { text = '┃' },
      change = { text = '┃' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    signs_staged_enable = true,

    -- set these to keymaps?
    signcolumn = true, -- `:Gitsigns toggle_signs`
    numhl = false, -- `:Gitsigns toggle_numhl`
    linehl = false, -- `:Gitsigns toggle_linehl`
    word_diff = false, -- `:Gitsigns toggle_word_diff`
    current_line_blame = false, -- `:Gitsigns toggle_current_line_blame`
    -- :Gitsigns preview_hunk

    watch_gitdir = {
      follow_files = true,
    },

    auto_attach = true,
    attach_to_untracked = false,

    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 100,
      use_focus = true,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',

    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
      -- Options passed to nvim_open_win
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
    },
    on_attach = function(bufnr)
      --:Gitsigns ---
      --stage_hunk
      --reset_hunk
      --preview_hunk-inline
      --preview_hunk
      --nav_hunk next/prev
      -- blame
      -- blame_line
      -- toggle_current_line_blame
      -- change_base <Revision>
      -- diffthis <Revisions>
      -- toggle_word_diff
      -- setqflist/setloclist target=all/attached/[int]
      -- set{'o', 'x'}, 'ih' <Cmd>Gitsigns selecthunk<CR>''
      -- set statusline+=%{get(b:,'gitsigns_status','')}
      -- show <revision>
      -- otehr toggles above

      local gitsigns = require 'gitsigns'

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { desc = 'next hunk/diff-chunk' })

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'prev hunk/diff-chunk' })

      -- Actions
      map('n', '<leader>gp', gitsigns.preview_hunk, { desc = '[g]it [p]review' })
      map('n', '<leader>gs', gitsigns.stage_hunk, { desc = '[g]it [s]tage' })
      map('n', '<leader>gr', gitsigns.reset_hunk, { desc = '[g]it [r]eset' })

      -- -- Actions
      -- map('n', '<leader>hs', gitsigns.stage_hunk)
      -- map('n', '<leader>hr', gitsigns.reset_hunk)
      --
      -- map('v', '<leader>hs', function()
      --   gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      -- end)
      --
      -- map('v', '<leader>hr', function()
      --   gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      -- end)
      --
      -- map('n', '<leader>hS', gitsigns.stage_buffer)
      -- map('n', '<leader>hR', gitsigns.reset_buffer)
      -- map('n', '<leader>hp', gitsigns.preview_hunk)
      -- map('n', '<leader>hi', gitsigns.preview_hunk_inline)
      --
      -- map('n', '<leader>hb', function()
      --   gitsigns.blame_line { full = true }
      -- end)
      --
      -- map('n', '<leader>hd', gitsigns.diffthis)
      --
      -- map('n', '<leader>hD', function()
      --   gitsigns.diffthis '~'
      -- end)
      --
      -- map('n', '<leader>hQ', function()
      --   gitsigns.setqflist 'all'
      -- end)
      -- map('n', '<leader>hq', gitsigns.setqflist)
      --
      -- -- Toggles
      -- map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
      -- map('n', '<leader>tw', gitsigns.toggle_word_diff)
      --
      -- -- Text object
      -- map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
    end,
  },
}

-- return {
--   {
--     'lewis6991/gitsigns.nvim',
--     opts = {
--       on_attach = function(bufnr)
--         local gitsigns = require 'gitsigns'
--
--         local function map(mode, l, r, opts)
--           opts = opts or {}
--           opts.buffer = bufnr
--           vim.keymap.set(mode, l, r, opts)
--         end
--
--         -- Navigation
--         map('n', ']c', function()
--           if vim.wo.diff then
--             vim.cmd.normal { ']c', bang = true }
--           else
--             gitsigns.nav_hunk 'next'
--           end
--         end, { desc = 'Jump to next git [c]hange' })
--
--         map('n', '[c', function()
--           if vim.wo.diff then
--             vim.cmd.normal { '[c', bang = true }
--           else
--             gitsigns.nav_hunk 'prev'
--           end
--         end, { desc = 'Jump to previous git [c]hange' })
--
--         -- Actions
--         -- visual mode
--         map('v', '<leader>hs', function()
--           gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
--         end, { desc = 'git [s]tage hunk' })
--         map('v', '<leader>hr', function()
--           gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
--         end, { desc = 'git [r]eset hunk' })
--         -- normal mode
--         map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
--         map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
--         map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
--         map('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'git [u]ndo stage hunk' })
--         map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
--         map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
--         map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
--         map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
--         map('n', '<leader>hD', function()
--           gitsigns.diffthis '@'
--         end, { desc = 'git [D]iff against last commit' })
--         -- Toggles
--         map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
--         map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
--       end,
--     },
--   },
-- }
--
-- make kepmap to move to next or prev diagnostic? '[d', '[D', ']d', ']D'
