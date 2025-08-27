if vim.loader then
  vim.loader.enable()
end

require("config.lazy")
require("config.lsp")
require("config.telescope")
require("config.remaps")
require("config.options")

-- require("lazy").setup({
--   {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"}
-- })

local lastplace = vim.api.nvim_create_augroup("LastPlace", {})
vim.api.nvim_clear_autocmds({ group = lastplace })
vim.api.nvim_create_autocmd("BufReadPost", {
  group = lastplace,
  pattern = { "*" },
  desc = "remember last cursor place",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.lsp.config['clangd'] = {
  cmd = { '/opt/llvm-project-20/build/bin/clangd' },
  -- cmd = { 'clangd' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  root_markers = {
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac', -- AutoTools
    '.git',
  },
  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
    offsetEncoding = { 'utf-8', 'utf-16' },
  },
  ---@param init_result ClangdInitializeResult
  on_init = function(client, init_result)
    if init_result.offsetEncoding then
      client.offset_encoding = init_result.offsetEncoding
    end
  end,
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspClangdSwitchSourceHeader', function()
      switch_source_header(bufnr, client)
    end, { desc = 'Switch between source/header' })

    vim.api.nvim_buf_create_user_command(bufnr, 'LspClangdShowSymbolInfo', function()
      symbol_info(bufnr, client)
    end, { desc = 'Show symbol info' })
  end,
}

vim.lsp.enable('clangd')

-- local clang_format_path = "/data/dynamatic/polygeist/llvm-project/build/bin/clang-format"
-- if vim.fn.executable(clang_format_path) == 1 then
--   vim.api.nvim_create_autocmd("BufWritePre", {
--     pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
--     callback = function()
--       local clang_format_config = vim.fn.findfile(".clang-format", ".;")
-- 
--       local pos = vim.api.nvim_win_get_cursor(0)
-- 
--       local buf = vim.api.nvim_get_current_buf()
--       local file = vim.api.nvim_buf_get_name(buf)
-- 
--       if file == "" then
--         vim.notify("No file to format (buffer not saved yet)", vim.log.levels.WARN)
--         return
--       end
-- 
--       -- Run clang-format on the file in-place
--       vim.fn.jobstart({ "clang-format", "-i", "--style=file", "--assume-filename=" .. file, file }, {
--         on_exit = function(_, code)
--           if code == 0 then
--             -- vim.schedule(function()
--             --   vim.cmd("edit!")
--             -- end)
--             vim.schedule(function()
--               vim.cmd("checktime")  -- reload if file changed outside
--             end)
--           else
--             vim.notify("clang-format failed", vim.log.levels.ERROR)
--           end
--         end,
--       })
--     end,
--   })
-- end
