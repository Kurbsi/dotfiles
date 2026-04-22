require('remap')
require('set')
require('tttech')

vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        print('name ' .. name .. ' kind ' .. kind)
        if name == 'nvim-treesitter' and kind == 'update' then
            if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
            vim.cmd('TSUpdate')
        end
    end
})

vim.pack.add({
    'https://github.com/folke/tokyonight.nvim',
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/nvim-lualine/lualine.nvim',
    'https://github.com/tpope/vim-fugitive',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/BurntSushi/ripgrep',
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
    { src = 'https://github.com/nvim-telescope/telescope.nvim', version = 'v0.2.1' },
    'https://github.com/romus204/tree-sitter-manager.nvim',
    { src = 'https://github.com/ThePrimeagen/harpoon',          version = 'harpoon2' },
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/nvim-mini/mini.surround',
    { src = 'https://github.com/saghen/blink.cmp', version = 'v1' },
    'https://github.com/rachartier/tiny-inline-diagnostic.nvim',
})

--  look & feel
vim.cmd.colorscheme('tokyonight-storm')
require('lualine').setup {
    options = {
        theme = 'tokyonight'
    }
}

-- Git
vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Git status' })
vim.keymap.set('n', '<leader>gco', ':G checkout ', { desc = 'Git checkout' })
vim.keymap.set('n', '<leader>gp', function() vim.cmd.Git('push') end, { desc = 'Git push' })
vim.keymap.set('n', '<leader>gf', function() vim.cmd.Git('push -f') end, { desc = 'Git push --force' })
vim.keymap.set('n', '<leader>gu', function() vim.cmd.Git('pull --rebase') end, { desc = 'Git pull --rebase' })
vim.keymap.set('n', '<leader>gbl', function() vim.cmd.Git('blame') end, { desc = 'Git blame' })
vim.keymap.set('n', "<leader>gl", function() vim.cmd.Git('log --graph --oneline --abbrev-commit') end,
    { desc = "Git lol" })

-- Telescope
require('telescope').setup {
    defaults = {
        path_display = { shorten = { len = 3, exclude = { 2, -1 } } },
    },
    extensions = {
        fzf = {}
    }
}
require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope find git files' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set({ 'n', 'v' }, '<leader>fw', builtin.grep_string, { desc = 'Telescope find word under cursor' })
vim.keymap.set('n', '<leader>frr', builtin.lsp_references, { desc = 'Telescope find references' })
vim.keymap.set('n', '<leader>fs', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fgb', builtin.git_branches, { desc = 'Telescope show git branches' })
vim.keymap.set('n', "<leader>fS", function()
        vim.ui.input({ prompt = "Exclude direcories: " },
            function(input)
                if not input or input == "" then
                    return
                end

                local dirs = {}
                for dir in input:gmatch("%S+") do
                    table.insert(dirs, '--glob=!**/' .. dir .. '/**')
                end

                require('telescope.builtin').live_grep({
                    prompt_title = 'Excluding: ' .. table.concat(dirs, ', '),
                    additional_args = dirs
                })
            end)
    end,
    { desc = 'Telescope find word while excluding direcories' })

-- tree-sitter-manager
require('tree-sitter-manager').setup({})

-- Harpoon
local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set('n', '<leader>h', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
    { desc = 'Toggle harpoon quick menu' })
vim.keymap.set('n', '<leader>ha', function() harpoon:list():add() end, { desc = 'Add buffer to harpoon' })
vim.keymap.set('n', '<M-u>', function() harpoon:list():select(1) end, { desc = 'Switch to harpoon buffer 1' })
vim.keymap.set('n', '<M-i>', function() harpoon:list():select(2) end, { desc = 'Switch to harpoon buffer 2' })
vim.keymap.set('n', '<M-o>', function() harpoon:list():select(3) end, { desc = 'Switch to harpoon buffer 3' })
vim.keymap.set('n', '<M-p>', function() harpoon:list():select(4) end, { desc = 'Switch to harpoon buffer 4' })
vim.keymap.set('n', '<C-S-P>', function() harpoon:list():prev() end, { desc = 'Go to next buffer in harpoon' })
vim.keymap.set('n', '<C-S-N>', function() harpoon:list():next() end, { desc = 'Go to prev buffer in harpoon' })

-- Oil
require("oil").setup({
    keymaps = { ['<C-p>'] = false, },
    view_options = { show_hidden = true }
})

vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

-- Mason
require('mason').setup()

-- LSP
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

vim.lsp.config('lua_ls', {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath('config')
                and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
            then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                version = 'LuaJIT',
                -- Tell the language server how to find Lua modules same way as Neovim
                -- (see `:h lua-module-load`)
                path = {
                    'lua/?.lua',
                    'lua/?/init.lua',
                },
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    -- Depending on the usage, you might want to add additional paths
                    -- here.
                    -- '${3rd}/luv/library',
                    -- '${3rd}/busted/library',
                },
                -- Or pull in all of 'runtimepath'.
                -- NOTE: this is a lot slower and will cause issues when
                -- working on your own configuration.
                -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                -- library = vim.api.nvim_get_runtime_file('', true),
            },
        })
    end,
    settings = {
        Lua = {},
    },
})

vim.lsp.enable({ 'clangd', 'cmake', 'lua_ls', 'bashls', 'pylsp' })

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set("n", "gh", "<cmd>LspClangdSwitchSourceHeader<CR>", { desc = "Switch between header/source" })

-- Mini.Sourround
require('mini.surround').setup()

-- Undotree
vim.cmd.packadd('nvim.undotree')
vim.keymap.set('n', '<leader>u', require('undotree').open, { desc = 'Toggle undo-tree' })

-- Blink.cmp
require('blink.cmp').setup({
    completion = {
        keyword = { range = 'prefix' },
        ghost_text = { enabled = true },
        list = { selection = { preselect = true, auto_insert = true } },
        menu = {
            draw = {
                columns = {
                    { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'source_name' },
                },
            },
        },
    },
    fuzzy = { implementation = 'lua' },
    keymap = {
        preset = 'default',
        ['<C-u>'] = { 'scroll_signature_up', 'fallback' },
        ['<C-d>'] = { 'scroll_signature_down', 'fallback' },
    }
})

-- tiny-inline-diagnostic
require("tiny-inline-diagnostic").setup()
vim.diagnostic.config({ virtual_text = false })
