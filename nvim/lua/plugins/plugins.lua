return {
	{
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
		event = "InsertEnter",
		dependencies = {
			"rafamadriz/friendly-snippets",
			{ "L3MON4D3/LuaSnip", version = "v2.*" },
		},
		opts = {
			snippets = { preset = "luasnip" },
			signature = { enabled = true },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup {
        auto_install = true,
        highlight = { enable = true },
      }
    end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			for _, server in ipairs {
				"lua_ls", -- pacman
        "gopls", -- go
			}  do
				vim.lsp.enable(server)
			end
		end,
	},
	-- try using :vimgrep and :grep
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>sb", "<CMD>FzfLua buffers<CR>", desc = "Search Buffers" },
			{ "<leader>sf", "<CMD>FzfLua files<CR>", desc = "Search Files" },
			{ "<leader>so", "<CMD>FzfLua oldfiles<CR>", desc = "Search Oldfiles" },
			{ "<leader>sl", "<CMD>FzfLua blines<CR>", desc = "Search BLines" },
		},
		cmd = { "FzfLua" },
	},
}
