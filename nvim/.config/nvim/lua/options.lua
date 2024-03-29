vim.opt.autochdir = true --  change dir to current file's
vim.opt.autoindent = true
vim.opt.clipboard = "unnamed" --  copy to the OS clipboard
vim.opt.expandtab = true
vim.opt.foldenable = true -- when off, all folds are open
vim.opt.foldlevel = 2
vim.opt.foldmethod = "indent"
vim.opt.foldnestmax = 10
vim.opt.mouse = "a" --  can select text and scroll with mouse
vim.opt.number = true
vim.opt.numberwidth = 1 --  linenum width
-- vim.opt.relativenumber = true --  linenums are relative now (abs in ruler)
vim.opt.shiftwidth = 2 --  On pressing tab, insert 2 spaces
vim.opt.showcmd = true --  show running command
vim.opt.showmatch = true --  highlight matching braces
vim.opt.signcolumn = "yes" -- always show SignColumn
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.sw = 2 --  2 space indent
vim.opt.tabstop = 2 --  when indenting with '>', use 2 spaces width
vim.opt.termguicolors = true --  enable 24-bit RGB colors
vim.opt.updatetime = 50
vim.opt.wrap = false

vim.opt.diffopt:append {'linematch:60'}  -- Improve diff mode, also fix gitsigns
