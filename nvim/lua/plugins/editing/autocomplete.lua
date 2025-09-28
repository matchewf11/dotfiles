return { --config later

  -- copying kickstart config
  -- change to my own later!!!

  'saghen/blink.cmp',
  event = 'InsertEnter',
  version = '1.*',
  dependencies = {
    { -- delte this or config it later (dont know what it does)
      -- look up (fn -> full function for my langs)
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        -- `friendly-snippets` contains a variety of premade snippets.
        --    See the README about individual language/framework/plugin snippets:
        --    https://github.com/rafamadriz/friendly-snippets
        -- {
        --   'rafamadriz/friendly-snippets',
        --   config = function()
        --     require('luasnip.loaders.from_vscode').lazy_load()
        --   end,
        -- },
      },
    },
    opts = {}, -- config this?
    'folke/lazydev.nvim',
  },

  opts = {
    keymap = {
      -- 'default' (recommended)
      -- <c-y> to accept completiojn
      --   expand snippets if lsp sent snippet
      --   'super-tab' for tab to accept
      --   'enter' for enter to accept
      --   'none' for no mappings
      --   read :help ins-completion

      -- All presets have the following mappings:
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      preset = 'default',

      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },
    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },
    completion = {
      -- By default, you may press `<c-space>` to show the documentation.
      -- Optionally, set `auto_show = true` to show the documentation after a delay.
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },
    snippets = { preset = 'luasnip' },
    -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
    -- which automatically downloads a prebuilt binary when enabled.
    --
    -- By default, we use the Lua implementation instead, but you may enable
    -- the rust implementation via `'prefer_rust_with_warning'`
    --
    -- See :h blink-cmp-config-fuzzy for more information
    fuzzy = { implementation = 'lua' },
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
