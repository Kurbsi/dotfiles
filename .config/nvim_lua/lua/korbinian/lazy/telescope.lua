return {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        { '<leader>ff', require('telescope.builtin').find_files,  desc = "Find all files" },
        { '<C-p>',      require('telescope.builtin').git_files,   desc = 'Find all files in git' },
        { '<leader>fb', require('telescope.builtin').buffers,     desc = 'Find all open buffers' },
        { '<leader>fh', require('telescope.builtin').help_tags,   desc = 'Find all help tags' },
        { '<leader>fg', require('telescope.builtin').live_grep,   desc = 'Live Search' },
        { '<leader>fw', require('telescope.builtin').grep_string, desc = 'Find word under cursor' },
        {
            '<leader>fs',
            function()
                require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
            end,
            desc = 'Find word'
        },
        { '<leader>fgc', require('telescope.builtin').git_commits,  desc = 'Find all git commits' },
        { '<leader>fgb', require('telescope.builtin').git_branches, desc = 'find all git branches' },
    },
}
