require('remap')
require('set')

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
    'https://github.com/nvim-treesitter/nvim-treesitter',
    { src = 'https://github.com/ThePrimeagen/harpoon',          version = 'harpoon2' },
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/nvim-mini/mini.surround',
    { src = 'https://github.com/saghen/blink.cmp', version = 'v1' },
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
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Telescope find word under cursor' })
vim.keymap.set('n',
    '<leader>fs',
    function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end,
    { desc = 'Telescope find word under cursor' }
)

-- Treesitter
require('nvim-treesitter').install { 'lua', 'cpp', 'markdown', 'python', 'cmake' }

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

vim.lsp.enable({ 'clangd', 'cmake', 'lua_ls' })

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })

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
    },
    fuzzy = { implementation = 'lua' },
    keymap = {
        preset = 'default',
        ['<C-u>'] = { 'scroll_signature_up', 'fallback' },
        ['<C-d>'] = { 'scroll_signature_down', 'fallback' },
    }
})
