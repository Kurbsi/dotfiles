set nocompatible
set number relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
set splitbelow
set splitright
set clipboard=unnamedplus
set ruler

" enable syntax and plugins
syntax enable 
filetype plugin on

" Provide tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" Set astyle as the beautifier. Use with gq
autocmd BufNewFile,BufRead *.h,*.hpp,*.c,*.cpp set formatprg=astyle

" map switching between splitted window to ctrl + <hjkl>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" enable no highlighting to ctr + h
" map <C-n> :nohl<cr>

" leader to ,
let mapleader = ","

" disable K looking stuff up
map K <Nop>

" highlight the status line
highlight StatusLine ctermfg=blue ctermbg=DarkGrey

" remap open of filebrowser to F2
nnoremap <F2> :Explore<CR>

" switch between header and source
nnoremap <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
" map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
"
" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>
