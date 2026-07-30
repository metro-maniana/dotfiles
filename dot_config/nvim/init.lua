vim.g.mapleader = " "
vim.keymap.set("n", "<leader>so", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")
vim.keymap.set("n", "<leader>m", "<cmd>w<CR><cmd>make<CR>")
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>")

-- Highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('TJ-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

require("config.lazy")

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 4

vim.opt.clipboard = "unnamedplus"

vim.o.termguicolors = true
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 2,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.opt.colorcolumn = "88"
vim.opt.scrolloff = 15
