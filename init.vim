if has("syntax")
  syntax on
endif

filetype plugin indent on

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
set splitbelow splitright
set hidden
set mouse=a
set colorcolumn=81

"" Plugins
call plug#begin('~/.config/nvim/plugged')
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'ryanoasis/vim-devicons'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'tpope/vim-fugitive'
    Plug 'sheerun/vim-polyglot'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'preservim/nerdcommenter'
    Plug 'ap/vim-css-color'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'neoclide/coc.nvim'
    Plug 'tpope/vim-eunuch'
    Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app && yarn install'}
    Plug 'jiangmiao/auto-pairs'
    Plug 'vim-airline/vim-airline'
    Plug 'mhinz/vim-startify'
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'Valloric/vim-operator-highlight'
    Plug 'mg979/vim-visual-multi'
    Plug 'numtostr/FTerm.nvim'
    Plug 'thaerkh/vim-workspace'
    Plug 'arithran/vim-delete-hidden-buffers'
    Plug 'Aoutnheub/evermonokai'
    Plug 'junegunn/rainbow_parentheses.vim'
call plug#end()

autocmd FileType python let b:coc_root_patterns = ['.git', '.env']
autocmd BufRead,BufNewFile *.clj setlocal tabstop=4 | setlocal shiftwidth=4

let g:lisp_rainbow = 1

let g:python_recommended_style = 0

let g:workspace_session_disable_on_args = 1
let g:workspace_autosave = 0

let g:AutoPairsMultilineClose = 0

let g:mkdp_auto_close = 1

""" Rainbow
augroup rainbow_lisp
    autocmd!
    autocmd FileType lisp,clojure RainbowParentheses
augroup END

let g:rainbow#colors = {
\   'dark': [
\     ['1',  '#ff6188'     ],
\     ['3',   '#fc9867'     ],
\     ['6',    '#ffd866' ],
\     ['2', '#a9dc76'      ],
\     ['4',     '#78dce8'],
\     ['5',  '#ab9df2'       ]
\   ]
\ }

"" Conceal
let g:vim_json_syntax_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

"" Indent guides
lua <<EOF
require("indent_blankline").setup {
    char = "┊",
    buftype_exclude = {"terminal"}
}
EOF

"" Hidden buffers
nnoremap <C-h> :DeleteHiddenBuffers<CR>

"" Coc
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

"" Colorscheme
set termguicolors
let g:evermonokai_enable_italic = 1
let g:evermonokai_background = 'hard'
let g:evermonokai_sign_column_background = 'none'
let g:evermonokai_show_eob = 0
let g:evermonokai_better_performance = 1
colorscheme evermonokai

"" Operator highlight
let g:ophigh_color = 10
let g:ophigh_color_gui = "#ff6188"

"" NerdTree
let g:NERDTreeWinSize = 35
let g:NERDTreeShowHidden = 1
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDTreeSortHiddenFirst = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

" Start NERDTree, unless a session is specified
autocmd VimEnter * if v:this_session == '' | NERDTree | wincmd p | endif

map <expr> <C-b> exists('g:NERDTree') && g:NERDTree.IsOpen() ? ':NERDTreeToggle<CR>' : ':NERDTreeMirror<CR>:NERDTreeFocus<CR>'

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

"" Statusline
let g:airline_theme = 'evermonokai'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.dirty='✗'
let g:airline_symbols.linenr = ' Ln:'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.colnr = ' Col:'

"" Tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ' '

" use <c-space>for trigger completion
inoremap <silent><expr> <NUL> coc#refresh()

"" NerdCommenter
vmap \\ <plug>NERDCommenterToggle
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '//', 'right': '' } }

"" Coc
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()

inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <c-space>for trigger completion
inoremap <silent><expr> <NUL> coc#refresh()

"" Don't move the cursor back when exiting INSERT
let CursorColumnI = 0
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif

"" Workspace
set sessionoptions+=options

"" Terminal
command! FTermToggle lua require("FTerm").toggle()<CR>
nnoremap <C-t> :FTermToggle<CR>

"" Startify
let g:startify_custom_header = [
            \ '    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
            \ '    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║',
            \ '    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║',
            \ '    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
            \ '    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
            \ '    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
            \ ]

let g:startify_bookmarks = [
            \ '~/Projects',
            \ '~/temp',
            \ '~/.config/nvim/init.vim',
            \ '~/.config/kitty/kitty.conf',
            \ '~/LeetCode'
            \ ]

let g:startify_lists = [
            \ { 'type': 'sessions', 'header': ['   ﮦ Sessions'] },
            \ { 'type': 'bookmarks', 'header': ['    Bookmarks'] },
            \ { 'type': 'dir', 'header': ['    Current Directory: '. getcwd()] },
            \ ]
