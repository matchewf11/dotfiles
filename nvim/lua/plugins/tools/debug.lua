-- rust and lua
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui', -- debugger ui (config this?)
    'nvim-neotest/nvim-nio', -- needed for dap-ui (config this?)
    'mason-org/mason.nvim', -- (Config these) -- installs debuggers
    'jay-babu/mason-nvim-dap.nvim', -- (config these) -- installs debuggers

    -- add more debuggers here (config them)
    -- 'leoluz/nvim-dap-go',
  },
  keys = {
    -- make sure to write these in maps
    -- make category in which key
    {
      '<leader>dc',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<leader>di',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<leader>do',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<leader>dx',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },

    {
      '<leader>dB',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    {
      '<leader>dr',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_installation = true, -- tries best to set up automatically
      handlers = {}, -- can provide additional configuration (edit this)
      ensure_installed = { -- install stuff here
        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
      },
    }

    -- dap ui setup, config this later
    -- edit the icons
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    --     -- Change breakpoint icons
    --     -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    --     -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    --     -- local breakpoint_icons = vim.g.have_nerd_font
    --     --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
    --     --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    --     -- for type, icon in pairs(breakpoint_icons) do
    --     --   local tp = 'Dap' .. type
    --     --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    --     --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    --     -- end
    --
    --     dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    --     dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    --     dap.listeners.before.event_exited['dapui_config'] = dapui.close
    --
    --     -- Install golang specific config
    --     require('dap-go').setup {
    --       delve = {
    --         -- On Windows delve must be run attached or it crashes.
    --         -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
    --         detached = vim.fn.has 'win32' == 0,
    --       },
    --     }
  end,
}

-- :DapToggleBreakpoint
-- :DapNew
-- :DapContinue
-- :DapStepOver
-- :DapStepInto
-- lua thing, go thing, c thing, rust thing, ocaml thing
--
--     Install nvim-dap like any other Neovim plugin:
--         git clone https://codeberg.org/mfussenegger/nvim-dap.git ~/.config/nvim/pack/plugins/start/nvim-dap
--         Or with vim-plug: Plug 'mfussenegger/nvim-dap'
--         Or with packer.nvim: use 'mfussenegger/nvim-dap'
--     Generate the documentation for nvim-dap using :helptags ALL or :helptags <PATH-TO-PLUGIN/doc/>
--
-- Supported Neovim versions:
--
--     Latest nightly
--     0.11.x (Recommended)
--     0.10.4
--
-- You'll need to install and configure a debug adapter per language. See
--
--     :help dap.txt
--     the Debug-Adapter Installation wiki
--     :help dap-adapter
--     :help dap-configuration
--
-- Usage
--
-- A typical debug flow consists of:
--
--     Setting breakpoints via :DapToggleBreakpoint or :lua require'dap'.toggle_breakpoint().
--     Launching debug sessions and resuming execution via :DapNew and :DapContinue or :lua require'dap'.continue().
--     Stepping through code via :DapStepOver, :DapStepInto or the corresponding functions :lua require'dap'.step_over() and :lua require'dap'.step_into().
--     Inspecting the state:
--         Via the built-in REPL: :lua require'dap'.repl.open()
--             Try typing an expression followed by ENTER to evaluate it.
--             Try commands like .help, .frames, .threads.
--             Variables with structure can be expanded and collapsed with ENTER on the corresponding line.
--         Via the widget UI (:help dap-widgets). Typically you'd inspect values, threads, stacktrace ad-hoc when needed instead of showing the information all the time, but you can also create sidebars for a permanent display
--         Via UI extensions:
--             IDE like: nvim-dap-ui
--             Middle ground between the IDE like nvim-dap-ui and the built-in widgets: nvim-dap-view
--             Show inline values: nvim-dap-virtual-text
--
-- See :help dap.txt, :help dap-mapping and :help dap-api.
--
-- Tip:
--
-- The arrow keys are good candidates for keymaps to step through code as their direction resembles the direction you'll step to.
--
--     Down: Step over
--     Right: Step into
--     Left: Step out
--     Up: Restart frame
--
-- You can setup keymaps temporary during a debug session using event listeners. See :help dap-listeners.
-- Supported languages
--
-- In theory all of the languages for which a debug adapter exists should be supported.
--
--     Available debug adapters
--     nvim-dap Debug-Adapter Installation & Configuration
--
-- The Wiki is community maintained. If you got an adapter working that isn't listed yet, please extend the Wiki.
--
-- Some debug adapters have language specific extensions. Using them over a manual configuration is recommended, as they're usually better maintained.
--
-- If the instructions in the wiki for a debug adapter are not working, consider that debug adapters may have made changes since the instructions were written. You may want to read the release notes of the debug adapters or try with an older version. Please update the wiki if you discover outdated examples.
-- Goals
--
--     Have a basic debugger in Neovim.
--
--     Extensibility and double as a DAP client library. This allows other plugins to extend the debugging experience. Either by improving the UI or by making it easier to debug parts of an application.
--
--     All known extensions are listed in the Wiki. The wiki is community maintained. Please add new extensions if you built one or if you discovered one that's not listed.
--
-- Non-Goals
--
--     Debug adapter installations are out of scope. It's not the business of an editor plugin to re-invent a package manager. Use your system package manager. Use Nix. Use Ansible.
--
--     nvim-dapconfig
--
--     Vim support. It's not going to happen. Use vimspector instead.
--
-- Alternatives
--
--     vimspector
--
-- Contributing
--
-- Contributions are welcome:
--
--     Give concrete feedback about usability.
--     Triage issues. Many of the problems people encounter are debug adapter specific.
--     Improve upstream debug adapter documentation to make them more editor agnostic.
--     Improve the Wiki. But please refrain from turning it into comprehensive debug adapter documentation that should go upstream.
--     Write extensions.
--
-- Before making direct code contributions, please create a discussion or issue to clarify whether the change is in scope of the nvim-dap core.
--
-- Please keep pull requests focused and don't change multiple things at the same time.
-- Features
--
--     launch debug adapter
--     attach to debug adapter
--     toggle breakpoints
--     breakpoints with conditions
--     logpoints
--     set exception breakpoints
--     step over, step into, step out
--     step back, reverse continue
--     Goto
--     restart
--     stop
--     pause
--     evaluate expressions
--     REPL (incl. commands to show threads, frames and scopes)
