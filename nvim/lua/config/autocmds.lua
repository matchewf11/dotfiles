local function set_spacing(pattern, expandtab, tabstop_shiftwidth, softtabstop)
  vim.api.nvim_create_autocmd('FileType', {
    pattern = pattern,
    callback = function()
      vim.bo.expandtab = expandtab
      vim.bo.tabstop = tabstop_shiftwidth
      vim.bo.shiftwidth = tabstop_shiftwidth
      vim.bo.softtabstop = softtabstop
    end,
  })
end

local M = {}

function M.global()
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
      vim.hl.on_yank()
    end,
  })

  set_spacing('lua', true, 2, 2)
  set_spacing('go', false, 4, 4)
  set_spacing('c', true, 2, 2)
  set_spacing('make', false, 4, 0)
  set_spacing('rust', true, 4, 4)
  set_spacing('toml', true, 2, 2)
end

function M.lsp()
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),

    callback = function(event)
      require('config.keymaps').lsp()
      local function client_supports_method(client, method, bufnr)
        if vim.fn.has 'nvim-0.11' == 1 then
          return client:supports_method(method, bufnr)
        else
          return client.supports_method(method, { bufnr = bufnr })
        end
      end

      local client = vim.lsp.get_client_by_id(event.data.client_id)

      local hl_method = vim.lsp.protocol.Methods.textDocument_documentHighlight
      if client and client_supports_method(client, hl_method, event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
          end,
        })
      end
    end,
  })
end

return M
