return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
        require('nvim-treesitter.configs').setup({
            modules = {},
            sync_install = false,
            ensure_installed = { "bash", "c", "cmake", "cpp", "gitignore", "gitcommit", "go", "gomod", "json", "lua", "markdown", "rust", "vimdoc" },
            auto_install = false,
            ignore_install = {},
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
