if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

let g:vimspector_enable_mappings = 'HUMAN'

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'joshdick/onedark.vim', { 'as': 'onedark' }
Plug 'tomasiser/vim-code-dark', { 'as': 'codedark' }
Plug 'chriskempson/base16-vim'
Plug 'gosukiwi/vim-atom-dark', { 'as': 'atomdark' }

Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'ap/vim-css-color'
Plug 'vim-scripts/a.vim'

Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-python'}

Plug '~/Projects/vim_notes'

" Initialize plugin system
call plug#end()

let python_highlight_all=1
syntax enable

" Other Configurations
filetype plugin indent on
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set incsearch ignorecase smartcase nohlsearch
set ruler laststatus=2 showcmd showmode
set encoding=utf-8
set number relativenumber
set title
set path+=**
set path+=$HOME/ddad
set wildmenu
set wildmode=longest,list,full
set splitbelow splitright
set colorcolumn=120
" set termguicolors
set hidden
set noerrorbells
set nowrap
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

let mapleader=","
let g:equinusocio_material_darker=1

colorscheme atom-dark-256

function FormatBuffer()
  if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
    let cursor_pos = getpos('.')
    :%!clang-format-11
    call setpos('.', cursor_pos)
  endif
endfunction
autocmd BufWritePre *.h,*.hpp,*.c,*.cpp :call FormatBuffer()

function TrimWhiteSpace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction
autocmd BufWritePre * :call TrimWhiteSpace()

function! WriteTicketNote()
    " get current branch
    let l:git_branch = system("git branch --show-current")
    echom l:git_branch
    if stridx(l:git_branch, "master") >= 0
        let l:ticket = "master"
    else
        let l:ticket = split(l:git_branch, "_")[1]
    endif

    let l:fname = expand('~/notes/') . l:ticket . '.md'

    " edit the new file
    exec "e " . l:fname

    " enter the title and timestamp in the new file
    " exec normal ggO\<c-r>=strftime('%Y-%m-%d %H:%M')\<cr>\<cr>\<esc>
    exec "normal! ggO"
endfunction
command! -nargs=* Note call WriteTicketNote()

" ********** CUSTOMS **********

" map switching between splitted window to ctrl + <hjkl>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" toggle highlighting to leader + n
nnoremap <leader>h :set hlsearch! hlsearch?<CR>

" Close all open files
nnoremap QQ :qa!<CR>

" move between tabs
nnoremap <silent> th :tabprev<CR>
nnoremap <silent> tj :tabfirst<CR>
nnoremap <silent> tk :tablast<CR>
nnoremap <silent> tl :tabnext<CR>
nnoremap <silent> tm :tabedit %<CR>
nnoremap <silent> tn :tabnew<CR>

" terminal control
" pop-up, non-persistent terminal {{{

tnoremap <Esc> <C-\><C-n>

" move between panels while in terminal mode
" tnoremap <c-j> <c-\><c-n><c-w>j
" tnoremap <c-k> <c-\><c-n><c-w>k
" tnoremap <c-l> <c-\><c-n><c-w>l
" tnoremap <c-h> <c-\><c-n><c-w>h

" <c-n> will also close ternimal
" tnoremap <silent> <leader>/ :q<cr>

" start terminal in insert mode
autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif

" open terminal on <c-n>
function! OpenTerminal()
  split term://zsh
  resize 10
endfunction

nnoremap <silent> <leader>/ :call OpenTerminal()<cr>

nnoremap <silent> <leader>. :call nvim_open_win(bufnr('%'), v:true, {'relative': 'editor', 'anchor': 'SW', 'width': winwidth(0), 'height': 2*winheight(0)/5, 'row': 1, 'col': 0})<cr>:call TerminalToggle()<cr>
tnoremap <silent> <leader>. <c-\><c-n>:call TerminalToggle()<cr>:q<cr>

function! TerminalCreate() abort
  if !has('nvim')
    return v:false
  endif

  if !exists('g:terminal')
    let g:terminal = {
          \ 'opts': {},
          \ 'term': {
          \ 'loaded': v:null,
          \ 'bufferid': v:null
          \ },
          \ 'origin': {
          \ 'bufferid': v:null
          \ }
          \ }

    function! g:terminal.opts.on_exit(jobid, data, event) abort
      silent execute 'buffer' g:terminal.origin.bufferid
      silent execute 'bdelete!' g:terminal.term.bufferid

      let g:terminal.term.loaded = v:null
      let g:terminal.term.bufferid = v:null
      let g:terminal.origin.bufferid = v:null
    endfunction
  endif

  if g:terminal.term.loaded
    return v:false
  endif

  let g:terminal.origin.bufferid = bufnr('')

  enew
  call termopen(&shell, g:terminal.opts)

  let g:terminal.term.loaded = v:true
  let g:terminal.term.bufferid = bufnr('')
  startinsert
endfunction

function! TerminalToggle()
  if !has('nvim')
    return v:false
  endif

  " Create the terminal buffer.
  if !exists('g:terminal') || !g:terminal.term.loaded
    return TerminalCreate()
  endif

  " Go back to origin buffer if current buffer is terminal.
  if g:terminal.term.bufferid ==# bufnr('')
    silent execute 'buffer' g:terminal.origin.bufferid

    " Launch terminal buffer and start insert mode.
  else
    let g:terminal.origin.bufferid = bufnr('')

    silent execute 'buffer' g:terminal.term.bufferid
    startinsert
  endif
endfunction

" ********** PLUGINS **********

" coc.nvim

" Use tab for trigger completion with characters ahead and navigate.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" vim-polyglot
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1

" NERDTree
let NERDTreeShowHidden = 1
let g:NERDTreeDirArrowExpandable = '↠'
let g:NERDTreeDirArrowCollapsible = '↡'
let g:NERDTreeWinSize = 50
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeFind<CR>

" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1

" Airline
let g:airline_powerline_fonts = 1
let g:airline_section_z = ' %{strftime("%-I:%M %p")}'
let g:airline_section_warning = ''

" FZF
nnoremap <C-p> :FZF<CR>
nnoremap <leader>w :Rg <C-r><C-w><CR>
nnoremap ; :Buffers<CR>
let g:fzf_colors =
\ { "fg":      ["fg", "Normal"],
  \ "bg":      ["bg", "Normal"],
  \ "hl":      ["fg", "Normal"],
  \ "fg+":     ["fg", "CursorLine", "CursorColumn", "Normal"],
  \ "bg+":     ["bg", "CursorLine", "CursorColumn"],
  \ "hl+":     ["fg", "Normal"],
  \ "info":    ["fg", "Comment"],
  \ "border":  ["fg", "Ignore"],
  \ "prompt":  ["fg", "Comment"],
  \ "pointer": ["fg", "IncSearch"],
  \ "marker":  ["fg", "IncSearch"],
  \ "spinner": ["fg", "Comment"],
  \ "header":  ["fg", "WildMenu"] }

" a.vim
nnoremap <silent>gs :A<CR>
nnoremap <leader>f :IHV<CR>

" fugitive
nnoremap <leader>g :G<CR>
nnoremap <leader>gc :G commit
nnoremap <leader>gco :G checkout
nnoremap <leader>gp :G push<CR>
nnoremap <leader>gpu :G pull<CR>
nnoremap <leader>gd :G diff<CR>

" rhubarb
let g:github_enterprise_urls = ['https://cc-github.bmwgroup.net']
nnoremap <leader>gb :Gbrowse

" vim-cpp-modern
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1







