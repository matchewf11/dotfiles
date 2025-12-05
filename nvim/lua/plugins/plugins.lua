return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		opts = { contrast = "hard" },
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
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			for _, server in ipairs({
				"lua_ls", -- pacman
			}) do
				vim.lsp.enable(server)
			end
		end,
	},
	{
		"stevearc/oil.nvim",
		opts = { delete_to_trash = true },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		keys = { { "<leader>e", "<CMD>Oil<CR>", desc = "Open Oil" } },
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
		keys = {
			{ "<leader>sb", "<CMD>FzfLua buffers<CR>", desc = "Search Buffers" },
			{ "<leader>sf", "<CMD>FzfLua files<CR>", desc = "Search Files" },
			{ "<leader>so", "<CMD>FzfLua oldfiles<CR>", desc = "Search Oldfiles" },
			{ "<leader>sl", "<CMD>FzfLua blines<CR>", desc = "Search BLines" },
		},
		cmd = { "FzfLua" },
	},
}
