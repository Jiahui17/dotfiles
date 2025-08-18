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
    end
  end
})
