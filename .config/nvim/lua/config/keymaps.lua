vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')


vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set("n", "<C-Left>",  "<cmd>vertical resize +2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize -2<cr>", { desc = "Increase window width" })
vim.keymap.set("n", "<C-Up>",    "<cmd>resize -2<cr>",          { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>",  "<cmd>resize +2<cr>",          { desc = "Decrease window height" })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})


