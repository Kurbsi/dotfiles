-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup({
    view = {
        width = 50
    },
})

vim.keymap.set("n", "<leader>n", ":NvimTreeFindFileToggle<CR>")
