if vim.loader then
  vim.loader.enable()
end

require("config.lazy")
require("config.lsp")
require("config.telescope")
require("config.remaps")
require("config.options")
require("config.filetype")

-- vim.lsp.log.set_level(vim.log.levels.OFF)

-- require('black-nvim').setup({})

-- require("lazy").setup({
--   {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"}
-- })


