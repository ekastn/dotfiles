return {
	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for install instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			-- See :Telescope help_tags
			--
			-- Two important keymaps to use while in telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require("telescope").setup({
				-- defaults = {
				--   mappings = {
				--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
				--   },
				-- },
				-- pickers = {}
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable telescope extensions, if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>vh", builtin.help_tags, { desc = "find help" })
			vim.keymap.set("n", "<leader>vk", builtin.keymaps, { desc = "find keymaps" })
			vim.keymap.set("n", "<leader>fd", builtin.find_files, { desc = "find files" })
			vim.keymap.set("n", "<leader>vts", builtin.builtin, { desc = "find select telescope" })
			vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "find current word" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "search by grep" })
			vim.keymap.set("n", "<leader>ds", builtin.diagnostics, { desc = "diagnostics search" })
			vim.keymap.set("n", "<leader>vsr", builtin.resume, { desc = "search resume" })
			vim.keymap.set("n", "<leader>vs.", builtin.oldfiles, { desc = "search recent files" })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Find existing buffers" })

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "Fuzzily search in current buffer" })

			-- Also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>f/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "search in Open Files" })

			-- Shortcut for searching your neovim configuration files
			vim.keymap.set("n", "<leader>vn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "search neovim files" })
		end,
	},
}
