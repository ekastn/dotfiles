require("editor.options")
require("editor.keymap")
require("editor.lazy")
require("editor.autocmd")

vim.cmd.colorscheme("gruvbox")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NosmalFloat", { bg = "none" })
