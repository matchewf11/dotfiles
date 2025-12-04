return {
	{ 
		'ellisonleao/gruvbox.nvim', 
		priority = 1000 , 
		opts = { contrast = 'hard' }
	},
	{
		"nvim-treesitter/nvim-treesitter", 
		branch = 'master', 
		lazy = false, 
		build = ":TSUpdate"
	},
	{
	  'stevearc/oil.nvim',
	  opts = { delete_to_trash = true },
	  dependencies = { "nvim-tree/nvim-web-devicons" }, 
	  lazy = false,
	  keys = { {'<leader>e', '<CMD>Oil<CR>', desc = 'Open Oil'} },
	},
}
