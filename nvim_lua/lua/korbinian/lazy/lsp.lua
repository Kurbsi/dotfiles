return {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
        { "mason-org/mason.nvim", opts = {}, },
    },
    keys = {
        { 'gd', vim.lsp.buf.definition, desc = "Go to definition" },
        { '<leader>gh', ":LspClangdSwitchSourceHeader<CR>", desc = "Switch between header and source file" },
    },
    config = function()
        vim.diagnostic.config({
            virtual_text = {
                prefix = '',
                spacing = 4,
            },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })

        vim.lsp.config('pylsp', { settings = { pylsp = { plugins = { pycodestyle = { maxLineLength = 120 } } } } })
        vim.lsp.config('groovyls', { cmd = { "groovy-language-server" } })

        vim.lsp.enable({
            'pylsp',
            'clangd',
            'cmake',
            'bashls',
            'groovyls',
            'lua_ls'
        })

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('my.lsp', {}),
            callback = function(args)
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

                if not client:supports_method('textDocument/willSaveWaitUntil')
                    and client:supports_method('textDocument/formatting') then
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
                        buffer = args.buf,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                        end,
                    })
                end
            end,
        })
    end
}
