return {
    "sindrets/diffview.nvim",
    config = true,
    keys = {
        { '<leader>dvo', ':DiffviewOpen<CR>',                    desc = "Diff the working tree against the index:" },
        { '<leader>dvh', ':DiffviewFileHistory<CR>',             desc = "History for the current branch" },
        { '<leader>dvm', ':DiffviewFileHistory main...HEAD<CR>', desc = "Show all changes in current branch" },
    },
}
