vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Splits
vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-h>", "<C-W>h")
vim.keymap.set("n", "<C-l>", "<C-W>l")

-- Plugin remaps
vim.keymap.set("n", "<C-n>", vim.cmd.NERDTreeToggle)
vim.keymap.set("n", "<C-g>", vim.cmd.Goyo)
-- vim.keymap.set("n", "<leader>s", vim.cmd.easymotion - s2)
-- TODO: add coc remaps

vim.keymap.set("n", "gb", "<C-6")
-- OPT vim.keymap.set("n", "gf", "<C-^>")

silentNoremap = {
    noremap = true,
    silent = true
}

-- set({mode}, {lhs}, {rhs}, {opts})
vim.keymap.set('n', '<leader><left>', ":vertical resize +3<CR>", silentNoremap)
vim.keymap.set('n', "<leader><right>", ":vertical resize -3<CR>", silentNoremap)
vim.keymap.set('n', "<leader><up>", ":resize +3<CR>", silentNoremap)
vim.keymap.set('n', "<leader><down>", ":resize -3<CR>", silentNoremap)

-- MOVEMENTS
-- center cursor when going down or up by half pages
vim.keymap.set("n", "<C-d>", "<C-d>zz", silentNoremap)
vim.keymap.set("n", "<C-u>", "<C-u>zz", silentNoremap)
-- center cursor when searching
vim.keymap.set("n", "n", "nzz", silentNoremap)
vim.keymap.set("n", "N", "Nzz", silentNoremap)
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")
