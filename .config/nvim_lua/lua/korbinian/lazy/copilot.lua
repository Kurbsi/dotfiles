return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" },                       -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken",                            -- Only on MacOS or Linux
        opts = {
            -- See Configuration section for options
        },
        -- See Commands section for default commands if you want to lazy load on them
        keys = {
            { "<leader>coc", ":CopilotChatOpen<CR>",    mode = { "n", "v" }, noremap = true, silent = true, desc = "Copilot Open" },
            { "<leader>coe", ":CopilotChatExplain<CR>", mode = { "n", "v" }, noremap = true, silent = true, desc = "Copilot Explain" },
        },
    },
}
