local conf = require "modules.misc.config"
local misc = require("utils.pack").package

misc {
    enabled = false,
    "kylechui/nvim-surround",
    after = "nvim-treesitter",
    config = conf.surround,
}
