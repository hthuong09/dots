-- Set the map leader to space.
vim.g.mapleader = " "

-- Replace :q with :close to prevent accidentally quit vim
vim.cmd "cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>"

vim.api.nvim_set_keymap('n', '<leader>c', ':bp<cr>:bd #<cr>', {noremap = true, desc = "close buffer"})
vim.api.nvim_set_keymap('n', '<leader>C', ':bp<cr>:bd! #<cr>', {noremap = true, desc = "force close buffer"})
vim.api.nvim_set_keymap('n', '<Tab>', ':bnext<CR>', {noremap = true, desc = "next buffer"})
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bprevious<CR>', {noremap = true, desc = "previous buffer"})
vim.api.nvim_set_keymap('i', '<M-BS>', '<C-W>', { noremap = true, desc = "Option + Backspace to delete a word" })
vim.api.nvim_set_keymap('n', '<Esc>', '<cmd>nohlsearch<cr>', { noremap = true, desc = "Clear highlight when press Esc in normal map" })
vim.api.nvim_set_keymap('n', 'q', '<nop>', { noremap = true, desc = "disable neovim recording" })
