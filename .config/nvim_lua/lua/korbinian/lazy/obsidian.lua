return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    -- ft = "markdown",
    event = {
        "BufReadPre /c/Users/hirschmuelle/Documents/obsidian/korbinian",
        "BufNewFile /c/Users/hirschmuelle/Documents/obsidian/korbinian",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "korbinian",
                path = "/c/Users/hirschmuelle/Documents/obsidian/korbinian",
            },
        },
    },
}
