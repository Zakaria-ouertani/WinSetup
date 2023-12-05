vim.g.mapleader = " "

vim.keymap.set("n", "<leader>  ", vim.cmd.Ex, { desc = "Netrw File Manager" })

vim.keymap.set("n", "<leader> f", function()
    vim.lsp.buf.format()
end)

-- Move Block of code and indent
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv'")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv'")

-- Keep Cursor in the center when PgUp/PgDown
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep Cursor in the center when searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste
vim.keymap.set("x", "p", "\"_d")

-- Make vim clipboard need <leader>, and system clipboard without <leader>
--- Normal mode
vim.keymap.set({ "v", "n" }, "<leader>y", "y")
vim.keymap.set({ "v", "n" }, "<leader>p", "p")
vim.keymap.set({ "v", "n" }, "<leader>d", "d")
vim.keymap.set({ "v", "n" }, "<leader>dd", "dd")
vim.keymap.set({ "v", "n" }, "<leader>dw", "dw")

vim.keymap.set({ "v", "n" }, "d", "\"+d")
vim.keymap.set({ "v", "n" }, "y", "\"+y")
vim.keymap.set({ "v", "n" }, "p", "\"+p")
vim.keymap.set({ "v", "n" }, "dd", "\"+dd")
vim.keymap.set({ "v", "n" }, "dw", "\"+dw")

-- Global Replace Word
vim.keymap.set("n", "<leader>rw", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left>", { desc = "Replace Word" })

-- Pane Splitting / resizing
--- Splitting
vim.keymap.set("n", "<leader>-", ":split<CR>", { desc = "Horizontal Split" })
vim.keymap.set("n", "<leader>(", ":vsplit<CR>", { desc = "Veritcal Split" })

--- Resizing
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")

-- Exit Terminal Mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Buffers
--- Close Buffer
vim.keymap.set("n", "<leader>bc", ":bw<CR>", { desc = "Close Buffer" })
vim.keymap.set("n", "<TAB>", ":bnext<CR>")
vim.keymap.set("n", "<S-TAB>", ":bprevious<CR>", {desc = ""})


-- Multi Cursors
vim.keymap.set({"n", "v"}, "<leader>m", ":MCstart<CR>")

-- Utilities
vim.keymap.set("v", "<leader>rev", ":'<,'>!tac<CR>", {desc = "Reverse Selected Lines"})
vim.keymap.set("n", "<leader>fp", ":call setreg('+', getcwd() .. '\\' .. expand('%'))<CR>")
