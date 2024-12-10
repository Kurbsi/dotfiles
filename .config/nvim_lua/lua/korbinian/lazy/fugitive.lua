return {
    "tpope/vim-fugitive",
    dependencies = {
        "tommcdo/vim-fubitive"
    },
    lazy = false,
    config = function() vim.g.fubitive_domain_pattern = 'git.tttech.com' end,
    keys = {
        -- nnoremap <leader>gs :G stash<CR>
        { "<leader>gs",  vim.cmd.Git,                                                         desc = "Git status" },
        { "<leader>gb",  function() vim.cmd.Git("branch") end,                                desc = "Git branch" },
        { "<leader>gco", ":Git checkout ",                                                    desc = "Git checkout" },
        { "<leader>gl",  function() vim.cmd.Git('log --graph --oneline --abbrev-commit') end, desc = "Git lol" },
        { "<leader>gdm", function() vim.cmd.Git('diff main...') end,                          desc = "Git diff of current branch to merge base" },
        { "<leader>gx",  ":GBrowse<cr>",                                                      desc = "Browse to current file" },
        { "<leader>gp",  function() vim.cmd.Git('push') end,                                  desc = "Git push" },
        { "<leader>gf",  function() vim.cmd.Git('push -f') end,                               desc = "Git push --force" },
        { "<leader>pu",  function() vim.cmd.Git('pull --rebase') end,                         desc = "Git pull --rebase" },
        -- NOTE: It allows me to easily set the branch i am pushing and any tracking needed if i did not set the branch up correctly
        { "<leader>t",   ":Git push -u origin ",                                              ft = "fugitive",                                  desc = "Git push -u origin" },
    },
}
