return {
    -- colorscheme
    { "EdenEast/nightfox.nvim" },
    { "marko-cerovac/material.nvim" },
    { 
        "folke/tokyonight.nvim",
        config = function()
            vim.cmd('colorscheme tokyonight-night') 
        end
    },
    { "rose-pine/neovim", name = "rose-pine", }, 

    -- lualine
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup {
                theme = "tokyonight",
            }
        end
    }
}

