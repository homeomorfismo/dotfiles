require('lint').linters_by_ft = {
    -- todo
    -- markdown = {'markdownlint'},
    python = {'flake8', 'pylint'},
    cpp = {'cpplint'},
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})
-- au BufWritePost * lua require('lint').try_lint()
