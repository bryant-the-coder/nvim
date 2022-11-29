_G.global = {}

global.load_treesitter = not vim.tbl_contains({ "[packer]", "" }, vim.fn.expand "%")
