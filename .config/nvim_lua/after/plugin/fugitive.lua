-- nnoremap <leader>gco :G checkout<Space>
-- nnoremap <leader>gp :G push<Space>
-- nnoremap <leader>gpu :G pull<CR>
-- nnoremap <leader>gd :G diff<CR>
-- nnoremap <leader>gb :G branch<CR>
-- nnoremap <leader>gs :G stash<CR>

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

local korbinian_Fugitive = vim.api.nvim_create_augroup("korbinian_Fugitive", {})

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWinEnter", {
    group = korbinian_Fugitive,
    pattern = "*",
    callback = function()
        if vim.bo.ft ~= "fugitive" then
            return
        end
    
        local bufnr = vim.api.nvim_get_current_buf()
        local opts = {buffer = bufnr, remap = false}
        vim.keymap.set("n", "<leader>p", function()
            vim.cmd.Git('push')
        end, opts)
        
        -- rebase always
        vim.keymap.set("n", "<leader>P", function()
            vim.cmd.Git('pull --rebase')
        end, opts)
        
        -- NOTE: It allows me to easily set the branch i am pushing and any tracking
        -- needed if i did not set the branch up correctly
        vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
    end,
})
