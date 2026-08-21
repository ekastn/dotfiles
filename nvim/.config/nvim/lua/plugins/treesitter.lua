return {
    { -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        dependencies = {
            {
                "windwp/nvim-ts-autotag",
                config = function()
                    require("nvim-ts-autotag").setup()
                end,
            },
        },
        config = function()
            local langs = {
                "bash", "c", "cpp", "go", "sql", "html", "lua",
                "markdown", "vim", "vimdoc", "javascript", "typescript",
                "tsx", "python", "svelte", "blade",
            }
            require("nvim-treesitter").install(langs)

            local pending = {}

            local function start_highlight(buf, lang)
                pcall(vim.treesitter.start, buf, lang)
                vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end

            local function retry_start(lang, buf, tries)
                if vim.treesitter.language.add(lang) then
                    pending[lang] = nil
                    if vim.api.nvim_buf_is_valid(buf) then
                        start_highlight(buf, lang)
                    end
                elseif tries > 0 then
                    vim.defer_fn(function()
                        retry_start(lang, buf, tries - 1)
                    end, 1000)
                else
                    pending[lang] = nil
                    vim.notify("Failed to install treesitter parser for " .. lang, vim.log.levels.WARN)
                end
            end

            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
                    if not lang then
                        return
                    end
                    if vim.treesitter.language.add(lang) then
                        start_highlight(args.buf, lang)
                    elseif not pending[lang] then
                        pending[lang] = true
                        require("nvim-treesitter").install { lang }
                        retry_start(lang, args.buf, 30)
                    end
                end,
            })
        end,
    },
}
