-- Configurations when LSP is available (checkout :help LspAttach).
local autocmd = vim.api.nvim_create_autocmd
autocmd('LspAttach', {
  callback = function(e)
    -- Commands
    local opts = { buffer = e.buf }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<F2>", function() vim.lsp.buf.rename() end, opts)

    -- Autoformatting on save if LSP is available
    local client = assert(vim.lsp.get_client_by_id(e.data.client_id))
    if not client:supports_method('textDocument/willSaveWaitUntil')
      and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = e.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = e.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    -- else
    --   --  If the LSP does not provide a formatter: do it ourselves
    --   -- Format Python files with Black synchronously before saving
    --   vim.api.nvim_create_autocmd("BufWritePre", {
    --     pattern = "*.py",
    --     callback = function()
    --       vim.cmd("silent! execute '!black %'")
    --       vim.cmd("edit!")  -- Reload the buffer to reflect formatting changes
    --     end,
    --   })
    end
  end
})

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

vim.lsp.config['dslx_ls'] = {
  cmd = {'/data/xls/bazel-bin/xls/dslx/lsp/dslx_ls'},
  filetypes = {'dslx'}
}
vim.lsp.enable('dslx_ls')

vim.lsp.config['clangd'] = {
  cmd = {
    -- '/opt/llvm-project-20/build/bin/clangd',
    'clangd',
    '-j=8',
    -- '--malloc-trim',
    -- '--background-index',
    -- '--pch-storage=memory'
    },
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

vim.lsp.config['pylsp'] = {
  cmd = { 'pylsp' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
  },
  settings = {
    pylsp = {
      plugins = {
        -- formatter options
        -- pip install python-lsp-black
        black = { enabled = true },
        autopep8 = { enabled = true },
        yapf = { enabled = false },
        pycodestyle = { enabled = true, maxLineLength = 80 },
		    flake8 = { enabled = false },
      },
    },
  },
}
 
-- vim.lsp.enable('pylsp')

-- vim.lsp.config['pyright'] = {
--   cmd = { 'pyright-langserver', '--stdio' },
--   filetypes = { 'python' },
--   root_markers = {
--     'pyproject.toml',
--     'setup.py',
--     'setup.cfg',
--     'requirements.txt',
--     'Pipfile',
--     'pyrightconfig.json',
--     '.git',
--   },
--   settings = {
--     python = {
--       analysis = {
--         autoSearchPaths = true,
--         useLibraryCodeForTypes = true,
--         diagnosticMode = 'openFilesOnly',
--       },
--     },
--   },
-- }
-- 
-- vim.lsp.enable('pyright')


local function set_python_path(command)
  local path = command.args
  local clients = vim.lsp.get_clients {
    bufnr = vim.api.nvim_get_current_buf(),
    name = 'basedpyright',
  }
  for _, client in ipairs(clients) do
    if client.settings then
      client.settings.python = vim.tbl_deep_extend('force', client.settings.python or {}, { pythonPath = path })
    else
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = path } })
    end
    client:notify('workspace/didChangeConfiguration', { settings = nil })
  end
end

vim.lsp.config['basedpyright'] = {
  cmd = { 'basedpyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
    '.git',
  },
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly',
      },
    },
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightOrganizeImports', function()
      local params = {
        command = 'basedpyright.organizeimports',
        arguments = { vim.uri_from_bufnr(bufnr) },
      }

      -- Using client.request() directly because "basedpyright.organizeimports" is private
      -- (not advertised via capabilities), which client:exec_cmd() refuses to call.
      -- https://github.com/neovim/neovim/blob/c333d64663d3b6e0dd9aa440e433d346af4a3d81/runtime/lua/vim/lsp/client.lua#L1024-L1030
      client.request('workspace/executeCommand', params, nil, bufnr)
    end, {
    desc = 'Organize Imports',
  })

  vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightSetPythonPath', set_python_path, {
    desc = 'Reconfigure basedpyright with the provided python path',
    nargs = 1,
    complete = 'file',
  })
end,
}

vim.lsp.enable('basedpyright')

-- vim.lsp.config['mlir-lsp-server'] = {
--   cmd = { '/opt/llvm-project-20/build/bin/mlir-lsp-server' },
--   filetypes = { 'mlir', },
--   root_markers = { '.git' },
-- }
-- 
-- vim.lsp.enable('mlir-lsp-server')


--local function get_command()
  --local cmd = { 'tblgen-lsp-server' }
  --local files = vim.fs.find('tablegen_compile_commands.yml', { path = vim.fn.expand('%:p:h'), upward = true })
  --if #files > 0 then
    --local file = files[1]
    --table.insert(cmd, '--tablegen-compilation-database=' .. vim.fs.dirname(file) .. '/tablegen_compile_commands.yml')
  --end
--
  --return cmd
--end
--
--vim.lsp.config['tblgen-lsp-server'] = {
  --cmd = get_command,
  --filetypes = { 'tablegen', },
  --root_markers = { 'tblgen-lsp-server' },
--}
--
--vim.lsp.enable('tblgen-lsp-server')

-- vim.lsp.config['bsvlsp'] = {
--   cmd = {'/opt/venvs/venv3.10/bin/python3.10', '/data/bsvlsp/bsvlsp.py'},
--   filetypes = {'bsv'},
--   root_markers = { '.git' },
--   settings = {},
-- }
-- 
-- 
-- vim.lsp.enable('bsvlsp')

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
