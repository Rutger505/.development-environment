vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Which-key groups
require("which-key").add({
  { "<leader>c", group = "code" },
  { "<leader>f", group = "find" },
  { "<leader>g", group = "git" },
  { "<leader>t", group = "tab" },
  { "<leader>w", group = "window" },
  { "<leader>x", group = "diagnostics" },
})


-- Windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set("n", "<C-Left>",  "<cmd>vertical resize +2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize -2<cr>", { desc = "Increase window width" })
vim.keymap.set("n", "<C-Up>",    "<cmd>resize -2<cr>",          { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>",  "<cmd>resize +2<cr>",          { desc = "Decrease window height" })

-- Buffers
vim.keymap.set("n", "[b", "<cmd>bprev<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- Window
vim.keymap.set("n", "<leader>wc", "<cmd>close<cr>",   { desc = "Close Window" })
vim.keymap.set("n", "<leader>ws", "<cmd>split<cr>",   { desc = "Split Horizontal" })
vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<cr>",  { desc = "Split Vertical" })

-- Tabs
vim.keymap.set("n", "[t",         "<cmd>tabprev<cr>",  { desc = "Prev Tab" })
vim.keymap.set("n", "]t",         "<cmd>tabnext<cr>",  { desc = "Next Tab" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>",   { desc = "New Tab" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close Tab" })

-- Quickfix
vim.keymap.set("n", "[q", "<cmd>cprev<cr>", { desc = "Prev Quickfix" })
vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { desc = "Next Quickfix" })

-- Telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>",  { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>",   { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>",     { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>",   { desc = "Help Tags" })
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>",         { desc = "Todo Comments" })
vim.keymap.set("n", "<leader>f.", "<cmd>Telescope resume<cr>",       { desc = "Resume last search" })

-- Explorer
vim.keymap.set("n", "<leader>e", "<cmd>Neotree focus<cr>", { desc = "Focus Neo-tree" })

-- Format
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer (or selection)" })

-- Trouble
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                       { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",          { desc = "Buffer Diagnostics" })
vim.keymap.set("n", "<leader>xd", "<cmd>lua vim.diagnostic.open_float()<cr>",                  { desc = "Diagnostic Float" })
vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",               { desc = "Symbols" })
vim.keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",{ desc = "LSP Definitions" })

-- Git
vim.keymap.set("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "LazyGit" })
vim.keymap.set("n", "<leader>gs", function() require("gitsigns").stage_hunk() end,   { desc = "Stage Hunk" })
vim.keymap.set("n", "<leader>gr", function() require("gitsigns").reset_hunk() end,   { desc = "Reset Hunk" })
vim.keymap.set("n", "<leader>gp", function() require("gitsigns").preview_hunk() end, { desc = "Preview Hunk" })
vim.keymap.set("n", "<leader>gb", function() require("gitsigns").blame_line() end,   { desc = "Blame Line" })
vim.keymap.set("n", "[h", function() require("gitsigns").prev_hunk() end, { desc = "Prev Hunk" })
vim.keymap.set("n", "]h", function() require("gitsigns").next_hunk() end, { desc = "Next Hunk" })

-- Lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Mason
vim.keymap.set("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Mason" })

-- LSP (buffer-local, set on attach)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
    end
    map("gd",          vim.lsp.buf.definition,     "Go to Definition")
    map("gr",          vim.lsp.buf.references,     "Go to References")
    map("K",           vim.lsp.buf.hover,          "Hover Docs")
    map("<leader>cr",  vim.lsp.buf.rename,         "Rename")
    map("<leader>ca",  vim.lsp.buf.code_action,    "Code Action")
    map("<leader>cd",  vim.lsp.buf.declaration,    "Go to Declaration")
    map("<leader>ci",  vim.lsp.buf.implementation, "Go to Implementation")
    map("[d",          vim.diagnostic.goto_prev,   "Prev Diagnostic")
    map("]d",          vim.diagnostic.goto_next,   "Next Diagnostic")
    map("[e",          function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, "Prev Error")
    map("]e",          function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, "Next Error")
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
