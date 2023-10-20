require("toggleterm").setup()

vim.keymap.set('n', '<leader>th', ":ToggleTerm size=20 direction=horizontal<CR>", {desc = "Horizontal Split Terminal"})
vim.keymap.set('n', '<leader>tv', ":ToggleTerm size=80 direction=vertical<CR>", {desc = "Vertical Split Terminal"})
vim.keymap.set('n', '<leader>tf', ":ToggleTerm direction=float<CR>", {desc = "Floating Terminal"})
vim.keymap.set('n', '<leader>tt', ":ToggleTerm direction=tab<CR>", {desc = "Terminal Tab"})
