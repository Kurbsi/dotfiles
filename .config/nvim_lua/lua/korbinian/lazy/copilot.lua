local prompts = {
    -- Code related prompts
    Explain = "Please explain how the following code works.",
    Review = "Please review the following code and provide suggestions for improvement.",
    Tests = "Please explain how the selected code works, then generate unit tests for it.",
    Refactor = "Please refactor the following code to improve its clarity and readability.",
    FixCode = "Please fix the following code to make it work as intended.",
    FixError = "Please explain the error in the following text and provide a solution.",
    BetterNamings = "Please provide better names for the following variables and functions.",
    Documentation = "Please provide documentation for the following code.",
    SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
    SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
    -- Text related prompts
    Summarize = "Please summarize the following text.",
    Spelling = "Please correct any grammar and spelling errors in the following text.",
    Wording = "Please improve the grammar and wording of the following text.",
    Concise = "Please rewrite the following text to make it more concise.",
}

return {
    {
        {
            "github/copilot.vim",
            version = "v1.42.0",
            event = "VeryLazy",
            config = function()
                -- For copilot.vim
                -- enable copilot for specific filetypes
                vim.g.copilot_filetypes = {
                    ["TelescopePrompt"] = false,
                }

                -- Set to true to assume that copilot is already mapped
                vim.g.copilot_assume_mapped = true

                vim.g.copilot_no_tab_map = true
                vim.keymap.set('i', '<S-Tab>', 'copilot#Accept("\\<S-Tab>")',
                    { expr = true, replace_keycodes = false, silent = true, desc = "Accept Copilot suggestion" })


                -- Set workspace folders
                -- vim.g.copilot_workspace_folders = "~/Projects"

                -- Setup keymaps
                -- local keymap = vim.keymap.set
                -- local opts = { silent = true }
                --
                -- -- Set <C-y> to accept copilot suggestion
                -- keymap("i", "<C-y>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
                --
                -- -- Set <C-i> to accept line
                -- keymap("i", "<C-i>", "<Plug>(copilot-accept-line)", opts)
                --
                -- -- Set <C-j> to next suggestion, <C-k> to previous suggestion, <C-l> to suggest
                -- keymap("i", "<C-j>", "<Plug>(copilot-next)", opts)
                -- keymap("i", "<C-k>", "<Plug>(copilot-previous)", opts)
                -- keymap("i", "<C-l>", "<Plug>(copilot-suggest)", opts)
                --
                -- -- Set <C-d> to dismiss suggestion
                -- keymap("i", "<C-d>", "<Plug>(copilot-dismiss)", opts)
            end,
        },
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim",        branch = "master" }, -- for curl, log and async functions
            { "nvim-telescope/telescope.nvim" },                   -- Use telescope for help actions
        },
        build = "make tiktoken",                                   -- Only on MacOS or Linux
        event = "VeryLazy",
        opts = {
            headers = {
                user = '👤 You: ',
                assistant = '🤖 Copilot: ',
                tool = '🔧 Tool: ',
            },
            window = {
                title = '🤖 AI Assistant',
                laytout = "horizontal",
            },
            separator = '━━',
            prompts = prompts,
            model = "claude-3.7-sonnet",
            mappings = {
                -- Use tab for completion
                complete = {
                    detail = "Use @<Tab> or /<Tab> for options.",
                    insert = "<Tab>",
                },
                -- Close the chat
                close = {
                    normal = "gq",
                    insert = "<C-c>",
                },
                -- Reset the chat buffer
                reset = {
                    normal = "<C-x>",
                    insert = "<C-x>",
                },
                -- Submit the prompt to Copilot
                submit_prompt = {
                    normal = "<CR>",
                    insert = "<C-CR>",
                },
                -- Accept the diff
                accept_diff = {
                    normal = "<C-y>",
                    insert = "<C-y>",
                },
                -- Show help
                show_help = {
                    normal = "g?",
                },
            },
        },
        config = function(_, opts)
            local chat = require("CopilotChat")
            chat.setup(opts)

            local select = require("CopilotChat.select")
            vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
                chat.ask(args.args, { selection = select.visual })
            end, { nargs = "*", range = true })

            -- Inline chat with Copilot
            vim.api.nvim_create_user_command("CopilotChatInline", function(args)
                chat.ask(args.args, {
                    selection = select.visual,
                    window = {
                        layout = "float",
                        relative = "cursor",
                        width = 1,
                        height = 0.4,
                        row = 1,
                    },
                })
            end, { nargs = "*", range = true })

            -- Restore CopilotChatBuffer
            vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
                chat.ask(args.args, { selection = select.buffer })
            end, { nargs = "*", range = true })

            -- Custom buffer for CopilotChat
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "copilot-*",
                callback = function()
                    vim.opt_local.relativenumber = true
                    vim.opt_local.number = true

                    -- Get current filetype and set it to markdown if the current filetype is copilot-chat
                    local ft = vim.bo.filetype
                    if ft == "copilot-chat" then
                        vim.bo.filetype = "markdowvn"
                    end
                end,
            })
        end,
        keys = {
            {
                "<leader>ai",
                function()
                    local input = vim.fn.input("Ask Copilot: ")
                    if input ~= "" then
                        vim.cmd("CopilotChat " .. input)
                    end
                end,
                desc = "CopilotChat - Ask input",
            },
            {
                "<leader>ap",
                function()
                    require("CopilotChat").select_prompt({ context = { "buffers", }, })
                end,
                desc = "CopilotChat - Prompt actions",
            },
            {
                "<leader>ap",
                function()
                    require("CopilotChat").select_prompt()
                end,
                mode = "x",
                desc = "CopilotChat - Prompt actions",
            },
            { "<leader>ae",        "<cmd>CopilotChatExplain<cr>",       desc = "CopilotChat - Explain code" },
            { "<leader>at",        "<cmd>CopilotChatTests<cr>",         desc = "CopilotChat - Generate tests" },
            { "<leader>ar",        "<cmd>CopilotChatReview<cr>",        desc = "CopilotChat - Review code" },
            { "<leader>aR",        "<cmd>CopilotChatRefactor<cr>",      desc = "CopilotChat - Refactor code" },
            { "<leader>an",        "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
            { "<leader>aq",        "<cmd>CopilotChatClose<cr>",         desc = "CopilotChat - Close chat" },
            { "<leader>a<leader>", "<cmd>CopilotChatToggle<cr>",        desc = "CopilotChat - Toggle chat" },
            { "<leader>av",        ":CopilotChatVisual ",               mode = "x",                           desc = "CopilotChat - Open in vertical split", },
            { "<leader>ax",        ":CopilotChatInline ",               mode = "x",                           desc = "CopilotChat - Inline chat", },
        },
    },
}
