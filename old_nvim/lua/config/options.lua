vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.number = true
vim.o.relativenumber = true

vim.o.guicursor = 'a:block'
vim.o.cursorline = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.mouse = 'a'

vim.o.breakindent = true
vim.o.signcolumn = 'yes'

vim.o.undofile = true
vim.o.updatetime = 250

vim.o.timeoutlen = 300 -- time to finish a keymap

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.scrolloff = 10

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.laststatus = 3

function _G.statusline()
  local git = vim.b.gitsigns_head or ''
  if vim.b.gitsigns_status and vim.b.gitsigns_status ~= '' then
    git = git ~= '' and git .. ' ' .. vim.b.gitsigns_status or vim.b.gitsigns_status
  end

  local d = vim.diagnostic
  local sev = d.severity
  local diags = table.concat(
    vim.tbl_filter(
      function(s)
        return s
      end,
      vim.tbl_map(function(pair)
        local n = #d.get(0, { severity = pair[1] })
        return n > 0 and (pair[2] .. ':' .. n) or nil
      end, {
        { sev.ERROR, 'E' },
        { sev.WARN, 'W' },
        { sev.INFO, 'I' },
        { sev.HINT, 'H' },
      })
    ),
    ' '
  )

  local lsp = table.concat(
    vim.tbl_map(function(c)
      return c.name
    end, vim.lsp.get_clients { bufnr = 0 }),
    ', '
  )

  return ' '
    .. table.concat(
      vim.tbl_filter(function(s)
        return s ~= ''
      end, {
        '%t',
        '[%M%R%H%W%Y]%q',
        git,
        '%=',
        diags,
        lsp,
        '%l/%L:%c',
      }),
      ' | '
    )
    .. ' '
end

vim.o.statusline = '%!v:lua.statusline()'
