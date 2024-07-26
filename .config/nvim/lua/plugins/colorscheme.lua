return {
	"marko-cerovac/material.nvim",
	"folke/tokyonight.nvim",
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				styles = {
					bold = true,
					italic = false,
					transparency = true,
				},
			})
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		init = function()
			require("github-theme").setup({
				options = {
					transparent = true,
				},
			})
			vim.cmd.colorscheme("github_dark")
			-- vim.cmd.hi("Comment gui=none")
		end,
	},
}
