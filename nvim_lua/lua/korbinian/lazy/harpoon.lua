return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    keys = {
        { "<leader>h",  function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end, desc = "Toggle harpoon" },
        { "<leader>ha", function() require('harpoon'):list():add() end,                                    desc = "Add file to harpoon" },
        { "<M-u>",      function() require('harpoon'):list():select(1) end,                                desc = "Switch to harpoon buffer 1" },
        { "<M-i>",      function() require('harpoon'):list():select(2) end,                                desc = "Switch to harpoon buffer 2" },
        { "<M-o>",      function() require('harpoon'):list():select(3) end,                                desc = "Switch to harpoon buffer 3" },
        { "<M-p>",      function() require('harpoon'):list():select(4) end,                                desc = "Switch to harpoon buffer 4" },
        { "<C-S-P>",    function() require('harpoon'):list():prev() end,                                   desc = "Go to prev file in harpoon list" },
        { "<C-S-N>",    function() require('harpoon'):list():next() end,                                   desc = "Go to next file in harpoon list" },
    },
}
