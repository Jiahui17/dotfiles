-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<A-f>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<A-g>', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<A-b>', builtin.buffers, { desc = 'Telescope buffers' })
-- vim.keymap.set('n', '<Alt>h', builtin.help_tags, { desc = 'Telescope help tags' })

local telescope = require("telescope")
telescope.setup({
  defaults = {
    file_ignore_patterns = {
      "venv",
      "__pycache__",
      "%.xlsx",
      "%.jpg",
      "%.png",
      "%.webp",
      "%.pdf",
      "%.odt",
      "%.ico",
      "**/build/**",
    },
  },
})
