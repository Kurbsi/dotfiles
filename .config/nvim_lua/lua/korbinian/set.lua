--set ruler laststatus=2 showcmd showmode
--set path+=**
--set wildmenu
--set wildmode=longest,list,full
--set colorcolumn=120
--set cursorline
--set hidden
--set noerrorbells
--set nobackup
--set nowritebackup
--set clipboard+=unnamedplus
--set completeopt=menu,menuone,noselect


vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.cursorline = true

vim.opt.clipboard = "unnamedplus"

--Lua:
vim.g.material_style = "palenight"

--netrw
vim.g.netrw_banner = 0
