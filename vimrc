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

" Plugins
call plug#begin('~/.config/nvim/plugged')
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kyazdani42/nvim-tree.lua'
    "Plug 'ryanoasis/vim-devicons'
    "Plug 'preservim/nerdtree'
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
    "Plug 'akinsho/nvim-bufferline.lua'
    Plug 'Aoutnheub/notgruvbox'
    Plug 'vim-airline/vim-airline'
    Plug 'mhinz/vim-startify'
    Plug 'thaerkh/vim-indentguides'
    Plug 'Valloric/vim-operator-highlight'
call plug#end()

autocmd FileType python let b:coc_root_patterns = ['.git', '.env']

map <silent> <C-h> :CloseHiddenBuffers<CR>

let g:python_recommended_style = 0

let g:workspace_session_disable_on_args = 1
let g:workspace_autosave = 0

let g:AutoPairsMultilineClose = 0

let g:mkdp_auto_close = 1

" Conceal
let g:vim_json_syntax_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

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

" Colorscheme
set termguicolors
let g:gruvbox_italic = 1
colorscheme gruvbox

" Operator highlight
let g:ophigh_color = 10
let g:ophigh_color_gui = "#ff6188"

" Nvim Tree
let g:nvim_tree_width = 40
let g:nvim_tree_auto_close = 1
let g:nvim_tree_indent_markers = 1
"let g:nvim_tree_tab_open = 1
nnoremap <C-b> :NvimTreeToggle<CR>

let g:nvim_tree_show_icons = {
            \ 'git': 1,
            \ 'folders': 1,
            \ 'files': 1,
            \ 'folder_arrows': 1,
            \ }

highlight NvimTreeSymlink guifg=#ffd866
highlight NvimTreeFolderName guifg=#78dce8
highlight NvimTreeRootFolder guifg=#ff6188
highlight NvimTreeFolderIcon guifg=#78dce8
highlight NvimTreeEmptyFolderName guifg=#78dce8
highlight NvimTreeOpenedFolderName guifg=#78dce8
highlight NvimTreeExecFile guifg=#a9dc76
highlight NvimTreeOpenedFile guifg=#fcfcfa
highlight NvimTreeSpecialFile guifg=#fcfcfa
highlight NvimTreeImageFile guifg=#ab9df2
highlight NvimTreeMarkdownFile guifg=#fcfcfa
highlight NvimTreeIndentMarker guifg=#727072

highlight LspDiagnosticsError guifg=#ff6188
highlight LspDiagnosticsWarning guifg=#fc9867
highlight LspDiagnosticsInformation guifg=#78dce8
highlight LspDiagnosticsHint guifg=#ffd866

highlight NvimTreeLicenseIcon guifg=#fcfcfa
highlight NvimTreeYamlIcon guifg=#fcfcfa
highlight NvimTreeTomlIcon guifg=#fcfcfa
highlight NvimTreeGitignoreIcon guifg=#fcfcfa
highlight NvimTreeJsonIcon guifg=#fcfcfa

highlight NvimTreeLuaIcon guifg=#fcfcfa
highlight NvimTreePythonIcon guifg=#fcfcfa
highlight NvimTreeShellIcon guifg=#fcfcfa
highlight NvimTreeJavascriptIcon guifg=#fcfcfa
highlight NvimTreeCIcon guifg=#fcfcfa
highlight NvimTreeReactIcon guifg=#fcfcfa
highlight NvimTreeHtmlIcon guifg=#fcfcfa
highlight NvimTreeRustIcon guifg=#fcfcfa
highlight NvimTreeVimIcon guifg=#fcfcfa
highlight NvimTreeTypescriptIcon guifg=#fcfcfa

highlight NvimTreeGitDirty guifg=#fc9867
highlight NvimTreeGitStaged guifg=#a9dc76
highlight NvimTreeGitMerge guifg=#ab9df2
highlight NvimTreeGitRenamed guifg=#ffd866
highlight NvimTreeGitNew guifg=#78dce8
highlight NvimTreeGitDeleted guifg=#ff6188

" NerdTree
" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p
" let g:NERDTreeWinSize = 40
" let g:NERDTreeShowHidden = 1
" let g:NERDSpaceDelims = 1
" let g:NERDDefaultAlign = 'left'
" Start NERDTree, unless a session is specified
" autocmd VimEnter * if v:this_session == '' | NERDTree | wincmd p | endif
" map <expr> <C-b> exists('g:NERDTree') && g:NERDTree.IsOpen() ? ':NERDTreeToggle<CR>' : ':NERDTreeMirror<CR>:NERDTreeFocus<CR>'
" Exit Vim if NERDTree is the only window left.
" autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
"     \ quit | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
" autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
"     \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Statusline
let g:airline_theme = 'gruvbox'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.dirty='✗'
let g:airline_symbols.linenr = ' Line:'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.colnr = ' Col:'

" Tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ' '

" use <c-space>for trigger completion
inoremap <silent><expr> <NUL> coc#refresh()

" NerdCommenter
vmap \\ <plug>NERDCommenterToggle
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '//', 'right': '' } }

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

" Workspace
let g:workspace_autosave_untrailspaces = 0
let g:workspace_autosave_untrailtabs = 0

" Startify
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
