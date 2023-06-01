vim.bo.shiftwidth = 2
vim.o.conceallevel = 0
vim.bo.commentstring = "#%s"
vim.wo.spell = false
vim.bo.spelllang = "en"
vim.o.foldenable = false

vim.keymap.set({ "n", "i" }, "<A-q>", "<cmd>w<CR>")
vim.cmd([[hi link NeorgMarkupVerbatim Comment]])
