if has("syntax")
  syntax on
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
filetype plugin indent on

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

set tabstop=4
set shiftwidth=4
set expandtab
set number
set ve+=onemore
set noshowmode
set cursorline
set nofoldenable
set cino=l1
set encoding=UTF-8
set sessionoptions-=blank
set guicursor=
set nobackup
set nowritebackup

" Plugins
call plug#begin('~/.config/nvim/plugged')
    "Plug 'kyazdani42/nvim-web-devicons'
    Plug 'ryanoasis/vim-devicons'
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'tpope/vim-fugitive'
    Plug 'dylanaraps/wal.vim'
    Plug 'sheerun/vim-polyglot'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'preservim/nerdcommenter'
    Plug 'ap/vim-css-color'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'neoclide/coc.nvim'
    Plug 'tpope/vim-eunuch'
    Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app && yarn install'}
    Plug 'jiangmiao/auto-pairs'
    Plug 'thaerkh/vim-workspace'
    "Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
    Plug 'akinsho/nvim-bufferline.lua'
    Plug 'Aoutnheub/notgruvbox'
    Plug 'vim-airline/vim-airline'
call plug#end()

autocmd FileType python let b:coc_root_patterns = ['.git', '.env']

let g:python_recommended_style = 0

let g:workspace_session_disable_on_args = 1
let g:workspace_autosave = 0

let g:AutoPairsMultilineClose = 0

let g:mkdp_auto_close = 1

" Coc
nmap <silent> <C-c> <Plug>(coc-cursors-position)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Nvim Tree
let g:nvim_tree_width = 40
let g:nvim_tree_auto_close = 1
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_tab_open = 1
nnoremap <C-b> :NvimTreeToggle<CR>

" Colorscheme
set termguicolors
let g:gruvbox_italic = 1
colorscheme gruvbox
"let g:sonokai_style = 'shusia'
"let g:sonokai_enable_italic = 1
"let g:sonokai_disable_italic_comment = 1
"colorscheme sonokai

" Statusline
let g:airline_theme = 'gruvbox'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.dirty='✗'
let g:airline_symbols.linenr = ' Line:'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.colnr = ' Col:'

" Tabline
lua << EOF
require("bufferline").setup{}
EOF
nnoremap <silent><C-]> :BufferLineMoveNext<CR>
nnoremap <silent><C-[> :BufferLineMovePrev<CR>

" use <c-space>for trigger completion
inoremap <silent><expr> <NUL> coc#refresh()

" NerdCommenter
vmap \\ <plug>NERDCommenterToggle

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Don't move the cursor back when exiting INSERT
let CursorColumnI = 0
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif
