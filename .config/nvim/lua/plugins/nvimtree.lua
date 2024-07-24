return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local nvimtree = require("nvim-tree")

		-- disable netrw at the very start of your init.lua
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		nvimtree.setup({
			view = {
				width = 30,
				signcolumn = "auto",
				side = "right",
			},
			renderer = {
				indent_markers = { enable = true },
				icons = {
					git_placement = "signcolumn",
					diagnostics_placement = "after",
					glyphs = {
						git = {
							unstaged = "U",
							staged = "S",
							unmerged = "UM",
							renamed = "R",
							untracked = "UT",
							deleted = "D",
							ignored = "◌",
						},
					},
				},
			},
			actions = {
				open_file = {
					quit_on_open = true,
					-- disable window_picker for explorer to work well with window splits
					window_picker = {
						enable = false,
					},
				},
			},
			diagnostics = { enable = true },
			filters = { enable = false },
			git = { ignore = false },
		})

		vim.keymap.set("n", "<leader>fe", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
		vim.keymap.set(
			"n",
			"<leader>fc",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Toggle file explorer on current file" }
		)
		vim.keymap.set("n", "<leader>fj", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
		vim.keymap.set("n", "<leader>fr", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
	end,
}
