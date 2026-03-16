vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.o.number = true
vim.o.relativenumber = true

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Defer communicating to system clipboard after startup
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)


