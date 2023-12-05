local renamer = require("renamer")

renamer.setup()

vim.keymap.set({"n", "v"}, "<leader>rn", renamer.rename)
vim.keymap.set("i", "<F2>", renamer.rename)
