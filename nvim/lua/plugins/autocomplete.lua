-- finish this
--
-- copying kickstart config
-- change to my own later!!!
return {
  'saghen/blink.cmp',
  event = 'InsertEnter',
  version = '1.*',
  dependencies = { 'nvim-mini/mini.nvim' },
  opts = {
    keymap = {
      -- 'default' (recommended) <c-y> to accept completiojn
      --
      -- All presets have the following mappings:
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      preset = 'default',
    },
    appearance = { nerd_font_variant = 'mono' },
    completion = {
      -- By default, you may press `<c-space>` to show the documentation.
      -- Optionally, set `auto_show = true` to show the documentation after a delay.
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },

    snippets = { preset = 'mini_snippets' },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },
    fuzzy = { implementation = 'prefer_rust_with_warning' },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
  },
}

-- {
--   -- Enables keymaps, completions and signature help when true (doesn't apply to cmdline or term)
--   --
--   -- If the function returns 'force', the default conditions for disabling the plugin will be ignored
--   -- Default conditions: (vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false)
--   -- Note that the default conditions are ignored when `vim.b.completion` is explicitly set to `true`
--   --
--   -- Exceptions: vim.bo.filetype == 'dap-repl'
--   enabled = function() return not vim.tbl_contains({ "lua", "markdown" }, vim.bo.filetype) end,
--
--   -- Disable cmdline
--   cmdline = { enabled = false },
--
--   completion = {
--     -- 'prefix' will fuzzy match on the text before the cursor
--     -- 'full' will fuzzy match on the text before _and_ after the cursor
--     -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
--     keyword = { range = 'full' },
--
--     -- Disable auto brackets
--     -- NOTE: some LSPs may add auto brackets themselves anyway
--     accept = { auto_brackets = { enabled = false }, },
--
--     -- Don't select by default, auto insert on selection
--     list = { selection = { preselect = false, auto_insert = true } },
--     -- or set via a function
--     list = { selection = { preselect = function(ctx) return vim.bo.filetype ~= 'markdown' end } },
--
--     menu = {
--       -- Don't automatically show the completion menu
--       auto_show = false,
--
--       -- nvim-cmp style menu
--       draw = {
--         columns = {
--           { "label", "label_description", gap = 1 },
--           { "kind_icon", "kind" }
--         },
--       }
--     },
--
--     -- Show documentation when selecting a completion item
--     documentation = { auto_show = true, auto_show_delay_ms = 500 },
--
--     -- Display a preview of the selected item on the current line
--     ghost_text = { enabled = true },
--   },
--
--   sources = {
--     -- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
--     default = { 'lsp', 'path', 'snippets', 'buffer' },
--   },
--
--   -- Use a preset for snippets, check the snippets documentation for more information
--   snippets = { preset = 'default' | 'luasnip' | 'mini_snippets' },
--
--   -- Experimental signature help support
--   signature = { enabled = true }
-- }
--
--
--change appearence
--change completetion (keywork, trigger, list, accept, menu, )
-- (docs, ghost text, )
-- chagne fuzzy (rust/lua, installation, cofnig)
-- keymap(cmds, cmdline/term, presets, )
-- signatre
-- soruces
-- snippets
-- references
--
-- look at cmdline adn terminal mode
