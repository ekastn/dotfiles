return {
	{ -- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = "ibl",
		opts = {
			indent = { char = "┃" },
			whitespace = { highlight = { "Whitespace", "NonText" } },
		},
		-- config = function()
		-- 	require("ibl").setup({
		-- 		show_current_context = true,
		-- 		show_current_context_start = true,
		-- 		char = "┃",
		-- 	})
		-- end
	},
}
