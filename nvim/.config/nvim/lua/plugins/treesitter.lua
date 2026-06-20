return {
    { -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "windwp/nvim-ts-autotag",
        },
        config = function()
            -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup {
                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "go",
                    "sql",
                    "html",
                    "lua",
                    "markdown",
                    "vim",
                    "vimdoc",
                    "javascript",
                    "typescript",
                    "python",
                    "svelte",
                },
                -- Autoinstall languages that are not installed
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
                autotag = {
                    enable = true,
                },
            }

            local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
            parser_config.blade = {
                install_info = {
                    url = "https://github.com/EmranMR/tree-sitter-blade", -- The GitHub URL for the parser
                    files = { "src/parser.c" },
                    branch = "main", -- The default branch
                },
                filetype = "blade",
            }
        end,
    },
}
