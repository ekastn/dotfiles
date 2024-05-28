return {
	{
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = false,
			-- format_on_save = {
			-- 	timeout_ms = 1000,
			-- 	lsp_fallback = true,
			-- },
			formatters_by_ft = {
				lua = { "stylua" },
				c = { "clangd" },
				cpp = { "clangd" },
				python = { "isort", "black" },
				typescript = { { "prettierd", "prettier" } },
				javascript = { { "prettierd", "prettier" } },
				typescriptreact = { { "prettierd", "prettier" } },
				javascriptreact = { { "prettierd", "prettier" } },
				svelte = { "svelte" },
				css = { { "prettierd", "prettier" } },
				html = { { "prettierd", "prettier" } },
				htmldjango = { { "prettierd", "prettier" } },
				json = { { "prettierd", "prettier" } },
				yaml = { { "prettierd", "prettier" } },
				markdown = { { "prettierd", "prettier" } },
			},
		},
		vim.keymap.set({ "n", "v" }, "<leader>ff", function()
			require("conform").format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" }),
	},
}
