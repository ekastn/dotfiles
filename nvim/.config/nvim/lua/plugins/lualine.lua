return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "gruvbox_dark",
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
				-- block = { left = "█", right = "█" },
			},
			sections = {
				lualine_c = {
					{
						"filename",
						path = 1,
					},
				},
			},
		})
	end,
}
