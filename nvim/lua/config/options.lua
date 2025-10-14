vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = true
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'nosplit'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.o.guicursor = 'a:block'
vim.o.laststatus = 3

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

function _G.statusline()
  local severity = vim.diagnostic.severity

  local counts = { 0, 0, 0, 0 }
  for _, d in ipairs(vim.diagnostic.get(0)) do
    counts[d.severity] = counts[d.severity] + 1
  end

  local git_section = (function()
    if vim.b.gitsigns_head and vim.b.gitsigns_head ~= '' then
      local git_section = vim.b.gitsigns_head
      if vim.b.gitsigns_status and vim.b.gitsigns_status ~= '' then
        git_section = git_section .. ' ' .. vim.b.gitsigns_status
      end
      return git_section
    elseif vim.b.gitsigns_status and vim.b.gitsigns_status ~= '' then
      return vim.b.gitsigns_status
    end
  end)()

  return ' '
    .. table.concat(
      vim.tbl_filter(function(s)
        return s ~= ''
      end, {
        '%t',
        '[%M%R%H%W%Y]%q',
        git_section,
        '%=',
        table.concat(
          vim.tbl_filter(
            function(v)
              return v
            end,
            vim.tbl_map(function(sev_tbl)
              if counts[sev_tbl[1]] > 0 then
                return sev_tbl[2] .. ':' .. counts[sev_tbl[1]]
              end
            end, {
              { severity.ERROR, 'E' },
              { severity.WARN, 'W' },
              { severity.INFO, 'I' },
              { severity.HINT, 'H' },
            })
          ),
          ' '
        ),
        table.concat(
          vim.tbl_map(function(client)
            return client.name
          end, vim.lsp.get_clients { bufnr = 0 }),
          ', '
        ),
        '%l/%L:%c',
      }),
      ' | '
    )
    .. ' '
end

vim.o.statusline = '%!v:lua.statusline()'
