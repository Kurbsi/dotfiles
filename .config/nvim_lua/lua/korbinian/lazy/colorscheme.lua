return {
    -- colorscheme
    { "EdenEast/nightfox.nvim" },
    {
        "folke/tokyonight.nvim",
        -- config = function()
        --     vim.cmd('colorscheme tokyonight-night')
        -- end
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    },
    { "marko-cerovac/material.nvim" },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                theme = "auto",
            })
        end
    },
    {
        "levouh/tint.nvim",
        config = function()
            require("tint").setup({
                tint = -50,
            })
        end
    }
}

