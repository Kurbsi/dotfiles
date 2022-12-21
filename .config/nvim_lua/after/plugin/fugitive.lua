-- nnoremap <leader>g :G<CR>
-- nnoremap <leader>gco :G checkout<Space>
-- nnoremap <leader>gp :G push<Space>
-- nnoremap <leader>gpu :G pull<CR>
-- nnoremap <leader>gd :G diff<CR>
-- " nnoremap <leader>gb :G branch<CR>
-- nnoremap <leader>gs :G stash<CR>
-- nnoremap <leader>gb :G blame<CR>
-- vnoremap <leader>gb :G blame<CR>

vim.keymap.set("n", "<leader>g", vim.cmd.Git)
