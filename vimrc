" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

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
if !has('nvim')
  set t_RV=
  set ttymouse=xterm2
endif
if has('nvim')
  set guicursor=
endif
autocmd colorscheme * hi CursorLine cterm=none ctermfg=none ctermbg=none
autocmd colorscheme * hi CursorLineNr cterm=bold ctermfg=1 ctermbg=none
autocmd colorscheme * hi Visual cterm=none ctermfg=0 ctermbg=1
autocmd colorscheme * hi Type cterm=italic ctermfg=4
autocmd colorscheme * hi Comment cterm=italic
autocmd colorscheme * hi MatchParen cterm=underline ctermfg=2 ctermbg=none
autocmd colorscheme * hi String ctermfg=6
autocmd colorscheme * hi Constant ctermfg=2
autocmd colorscheme * hi PreProc ctermfg=3
vnoremap <leader>p "_dP"
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'dylanaraps/wal.vim'
Plug 'sheerun/vim-polyglot'
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'preservim/nerdcommenter'
Plug 'ap/vim-css-color'
Plug 'ntpeters/vim-better-whitespace'
Plug 'severin-lemaignan/vim-minimap'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-eunuch'
Plug 'ryanoasis/vim-devicons'
" Plug 'Yggdroot/indentLine'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'jiangmiao/auto-pairs'
Plug 'kassio/neoterm'
Plug 'thaerkh/vim-workspace'

" Initialize plugin system
call plug#end()

let g:airline_theme = 'wal'
let g:airline#extensions#tabline#enabled = 1
let g:minimap_highlight='ToolBarLine'
autocmd FileType python let b:coc_root_patterns = ['.git', '.env']
autocmd VimEnter * NERDTree | wincmd p
" autocmd BufWinEnter * silent NERDTreeMirror
set encoding=UTF-8
" let vim_markdown_preview_github=1
" let vim_markdown_preview_browser='Firefox'
let g:workspace_session_disable_on_args = 1
let g:workspace_autosave = 0
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:AutoPairsMultilineClose = 0
let g:NERDTreeWinSize = 40
let g:NERDTreeShowHidden = 1
let g:mkdp_auto_close = 1
" let g:airline_section_b = airline#section#create(['branch'])
" let g:airline#extensions#hunks#enabled = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ' '
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.dirty='✗'
let g:airline_symbols.linenr = ' '
let g:airline_symbols.maxlinenr = ''
let g:neoterm_default_mod='belowright' " open terminal in bottom split
let g:neoterm_size=16 " terminal split size
let g:neoterm_autoscroll=1 " scroll to the bottom when running a command
" let g:indentLine_char = '>'
" let g:indentLine_concealcursor = 'nc'
" let g:indentLine_conceallevel = 1
set sessionoptions-=blank

let g:python_recommended_style = 0

" set termguicolors
colorscheme wal

"let g:NERDTreeIndicatorMapCustom = {
"    \ "Modified"  : "✹",
"    \ "Staged"    : "✚",
"    \ "Untracked" : "✭",
"    \ "Renamed"   : "➜",
"    \ "Unmerged"  : "═",
"    \ "Deleted"   : "✖",
"    \ "Dirty"     : "✗",
"    \ "Clean"     : "✔︎",
"    \ "Ignored"   : "☒",
"    \ "Unknown"   : "?"
"    \ }
"let g:NERDTreeDirArrowExpandable = '▸'
"let g:NERDTreeDirArrowCollapsible = '▾'
map <expr> <C-b> exists('g:NERDTree') && g:NERDTree.IsOpen() ? ':NERDTreeToggle<CR>' : ':NERDTreeMirror<CR>:NERDTreeFocus<CR>'
vmap \\ <plug>NERDCommenterToggle
nnoremap <expr> <C-t> ':Ttoggle<CR>'
" use <c-space>for trigger completion
inoremap <silent><expr> <NUL> coc#refresh()
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Don't move the cursor back when exiting INSERT
let CursorColumnI = 0
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif
