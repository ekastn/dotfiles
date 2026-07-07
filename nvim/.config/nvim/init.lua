require("editor.options")
require("editor.keymap")
require("editor.lazy")
require("editor.autocmd")

vim.opt.background = "dark" -- set this to dark or light
vim.cmd.colorscheme("gruvbox")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NosmalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.diagnostic.config({ virtual_text = true })
