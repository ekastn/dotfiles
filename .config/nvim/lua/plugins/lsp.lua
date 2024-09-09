return {
    { -- LSP Configuration & Plugins
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for neovim
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            -- Useful status updates for LSP.
            { "j-hui/fidget.nvim", opts = {} },
        },
        config = function()
            --  This function gets run when an LSP attaches to a particular buffer.
            --    That is to say, every time a new file is opened that is associated with
            --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
            --    function will be executed to configure the current buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
                callback = function(event)
                    local builtin = require("telescope.builtin")
                    vim.keymap.set( "n", "gd", builtin.lsp_definitions, { buffer = event.buf, desc = "[G]oto [D]efinition" })
                    vim.keymap.set( "n", "gD", vim.lsp.buf.declaration, { buffer = event.buf, desc = "[G]oto [D]eclaration" })
                    vim.keymap.set( "n", "gr", builtin.lsp_references, { buffer = event.buf, desc = "[G]oto [R]eferences" })
                    vim.keymap.set( "n", "gi", builtin.lsp_implementations, { buffer = event.buf, desc = "[G]oto [I]mplementation" })
                    vim.keymap.set("n", "g.", vim.lsp.buf.code_action, { buffer = event.buf, desc = "[C]ode [A]ction" })
                    vim.keymap.set( "n", "<leader>D", builtin.lsp_type_definitions, { buffer = event.buf, desc = "Type [D]efinition" })
                    vim.keymap.set( "n", "gs", builtin.lsp_document_symbols, { buffer = event.buf, desc = "[D]ocument [S]ymbols" })
                    vim.keymap.set( "n", "<leader>fws", builtin.lsp_dynamic_workspace_symbols, { buffer = event.buf, desc = "[W]orkspace [S]ymbols" })
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = event.buf, desc = "[R]e[n]ame" }) vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = event.buf, desc = "Hover Documentation" })
                    vim.keymap.set( "i", "<C-k>", vim.lsp.buf.signature_help, { buffer = event.buf, desc = "LSP: Signature Help" })

                    -- The following two autocommands are used to highlight references of the
                    -- word under your cursor when your cursor rests there for a little while.
                    --    See `:help CursorHold` for information about when this is executed
                    --
                    -- When you move your cursor, the highlights will be cleared (the second autocommand).
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.server_capabilities.documentHighlightProvider then
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.clear_references,
                        })
                    end
                end,
            })

            -- LSP servers and clients are able to communicate to each other what features they support.
            --  By default, Neovim doesn't support everything that is in the LSP specification.
            --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
            --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            -- -- setting for ufo
            -- capabilities.textDocument.foldingRange = {
            -- 	dynamicRegistration = false,
            -- 	lineFoldingOnly = true,
            -- }

            --  Add any additional override configuration in the following tables. Available keys are:
            --  - cmd (table): Override the default command used to start the server
            --  - filetypes (table): Override the default list of associated filetypes for the server
            --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
            --  - settings (table): Override the default settings passed when initializing the server.
            --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
            local servers = {
                clangd = {
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--suggest-missing-includes",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--offset-encoding=utf-16",
                    },
                },
                gopls = {
                    settings = {
                        gopls = {
                            completeUnimported = true,
                            usePlaceholders = true,
                            analyses = {
                                unusedparams = true,
                            },
                        },
                    },
                },
                tsserver = {},
                pyright = {
                    settings = {
                        pyright = {
                            disableOrganizeImports = true,
                        },
                        python = {
                            analysis = {
                                ignore = { "*" }, -- Using Ruff
                            },
                        },
                    },
                },
                html = {
                    filetypes = {
                        "html",
                        "htmldjango",
                    },
                },
                cssls = {},
                emmet_ls = {
                    filetypes = {
                        "html",
                        "htmldjango",
                        "typescriptreact",
                        "javascriptreact",
                        "css",
                        "sass",
                        "scss",
                        "less",
                        "svelte",
                    },
                },
                tailwindcss = {},
                svelte = {},
                eslint = {},

                -- See `:help lspconfig-all` for a list of all the pre-configured LSPs
                --
                -- Some languages (like typescript) have entire language plugins that can be useful:
                --    https://github.com/pmizio/typescript-tools.nvim
                --
                -- But for many setups, the LSP (`tsserver`) will work just fine

                lua_ls = {
                    -- cmd = {...},
                    -- filetypes { ...},
                    -- capabilities = {},
                    settings = {
                        Lua = {
                            runtime = { version = "LuaJIT" },
                            workspace = {
                                checkThirdParty = false,
                                -- Tells lua_ls where to find all the Lua files that you have loaded
                                -- for your neovim configuration.
                                library = {
                                    "${3rd}/luv/library",
                                    unpack(vim.api.nvim_get_runtime_file("", true)),
                                },
                                -- If lua_ls is really slow on your computer, you can try this instead:
                                -- library = { vim.env.VIMRUNTIME },
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                            diagnostics = {
                                globals = { "vim" },
                            },
                            -- diagnostics = { disable = { 'missing-fields' } },
                        },
                    },
                },
            }

            -- Ensure the servers and tools above are installed
            --  To check the current status of installed tools and/or manually install
            --  other tools, you can run
            --    :Mason
            --
            --  You can press `g?` for help in this menu
            require("mason").setup()

            -- You can add other tools here that you want Mason to install
            -- for you, so that they are available from within Neovim.
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                "stylua",
                "prettier",
                "isort",
                "black",
                "ruff",
                "clang-format",
                "gofumpt",
                "goimports",
            })
            require("mason-tool-installer").setup { ensure_installed = ensure_installed }

            require("mason-lspconfig").setup {
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        -- This handles overriding only values explicitly passed
                        -- by the server configuration above. Useful when disabling
                        -- certain features of an LSP (for example, turning off formatting for tsserver)
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            }
        end,
    },
}
