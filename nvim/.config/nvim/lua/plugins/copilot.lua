return {
    "github/copilot.vim",
    event = "InsertEnter",
    cmd = "Copilot",
    config = function()
        -- Disable default <Tab> mapping to avoid conflict with nvim-cmp
        vim.g.copilot_no_tab_map = true

        -- Accept suggestion with <C-J> (fallback to <CR> when no suggestion)
        vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
            expr = true,
            replace_keycodes = false,
            desc = "Copilot: Accept suggestion",
        })

        -- Cycle through suggestions
        vim.keymap.set("i", "<M-]>", "<Plug>(copilot-next)", { desc = "Copilot: Next suggestion" })
        vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)", { desc = "Copilot: Previous suggestion" })

        -- Dismiss current suggestion
        vim.keymap.set("i", "<C-]>", "<Plug>(copilot-dismiss)", { desc = "Copilot: Dismiss suggestion" })

        -- Explicitly request a suggestion
        vim.keymap.set("i", "<M-\\>", "<Plug>(copilot-suggest)", { desc = "Copilot: Request suggestion" })
    end,
}
