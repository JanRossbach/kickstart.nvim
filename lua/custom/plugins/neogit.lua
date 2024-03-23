return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			"nvim-telescope/telescope.nvim",
		},
		config = true,
	},
	{
		"SuperBo/fugit2.nvim",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
			{
				"chrisgrieser/nvim-tinygit", -- optional: for Github PR view
				dependencies = { "stevearc/dressing.nvim" },
			},
			"sindrets/diffview.nvim", -- optional: for Diffview
		},
		cmd = { "Fugit2", "Fugit2Graph" },
		keys = {
			{ "<leader>F", mode = "n", "<cmd>Fugit2<cr>" },
		},
	},
}
