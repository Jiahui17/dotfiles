local autocmd = vim.api.nvim_create_autocmd
autocmd({"BufRead" ,"BufNewFile"}, {
    pattern = { '*.x' },
    -- pattern = "/(tasks|roles|handlers)/*ya?ml$",
    callback = function()
      vim.opt.filetype = "dslx"
    end,
    group = ansible_group
})
