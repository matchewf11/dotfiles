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
  set_spacing('json', true, 2, 2)
  set_spacing('haskell', true, 2, 2)
end

function M.lsp()
  -- When lsp attaches
  vim.api.nvim_create_autocmd('LspAttach', {
    -- create group 'lsp-attach', that starts empty
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),

    -- it then calls this back
    callback = function(event)
      -- set up lsp keymaps
      require('config.keymaps').lsp()
      local function client_supports_method(client, method, bufnr)
        return client:supports_method(method, bufnr)
      end

      -- get the client
      local client = vim.lsp.get_client_by_id(event.data.client_id)

      -- shorten the thing
      local hl_method = vim.lsp.protocol.Methods.textDocument_documentHighlight

      -- if lsp supports highlighting
      if client and client_supports_method(client, hl_method, event.buf) then
        -- creates lsp-highlight group
        local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

        -- highlights under cursor
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        -- removes
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        -- removes
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
