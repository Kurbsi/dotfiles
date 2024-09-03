return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "clangd",
                "lua_ls",
                "pylsp",
            },
            handlers = {
                function(server_name) -- default handlers
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["clangd"] = function()
                    require("lspconfig").clangd.setup {
                        capabilities = capabilities,
                        cmd = {
                            'cclangd',
                            'soa-com-middleware-motionwise-lean-1',
                        }
                    }
                end,

                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" }
                                }
                            }
                        }
                    }
                end,

                ["pylsp"] = function()
                    require("lspconfig").pylsp.setup {
                        capabilities = capabilities,
                        settings = {
                            pylsp = {
                                plugins = {
                                    pycodestyle = {
                                        maxLineLength = 120
                                    }
                                }
                            }
                        }
                    }
                end,
            }
        })

        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(e)
                local opts = { buffer = e.buf }
                opts.desc = ""
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                opts.desc = ""
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                opts.desc = ""
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                opts.desc = "Go to references"
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                opts.desc = "Rename symbol under cursor"
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                opts.desc = "Format buffer"
                vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, opts)
                opts.desc = "Show signature help"
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            end,
        })
    end
}
