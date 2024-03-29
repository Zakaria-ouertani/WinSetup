local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = "Telescope Find Files"})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = "Telescope Find Buffers"})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {desc = "Telescope Find Git Files"})
