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
}
