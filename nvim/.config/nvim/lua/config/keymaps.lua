-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Open terminal in a vertical split on the right
map("n", "<leader>fT", function()
  Snacks.terminal(nil, { win = { position = "right" } })
end, { desc = "Terminal (cwd, vertical)" })
map("n", "<leader>ft", function()
  Snacks.terminal(nil, { cwd = LazyVim.root(), win = { position = "right" } })
end, { desc = "Terminal (Root Dir, vertical)" })
map("n", "<c-/>", function()
  Snacks.terminal(nil, { cwd = LazyVim.root(), win = { position = "right" } })
end, { desc = "Terminal (Root Dir, vertical)" })
map("n", "<c-_>", function()
  Snacks.terminal(nil, { cwd = LazyVim.root(), win = { position = "right" } })
end, { desc = "which_key_ignore" })

-- Terminal Mappings (keep the close behavior unchanged)
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
