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
				c = { "clang-format" },
				cs = { "csharpier" },
				go = { "gofumpt", "goimports" },
				typescript = { "prettier" },
				javascript = { "prettier" },
				typescriptreact = { "prettier" },
				javascriptreact = { "prettier" },
				svelte = { "svelte" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				markdown = { "prettier" },
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
