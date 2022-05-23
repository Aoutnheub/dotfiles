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
" set colorcolumn=81
set termguicolors
set fillchars=stlnc:-

"" Plugins
call plug#begin('~/.config/nvim/plugged')
    " Plug 'ryanoasis/vim-devicons'
    Plug 'kyazdani42/nvim-web-devicons'
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
    Plug 'thaerkh/vim-workspace'
    Plug 'arithran/vim-delete-hidden-buffers'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'Aoutnheub/nightfall.vim'
    Plug 'matze/vim-move'
    Plug 'dhruvasagar/vim-table-mode'
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'akinsho/toggleterm.nvim'
call plug#end()

autocmd FileType python let b:coc_root_patterns = ['.git', '.env']
autocmd BufNewFile,BufRead *.frag,*.vert set ft=text | set syntax=c
autocmd BufNewFile,BufRead *.cshtml set ft=html

let g:python_recommended_style = 0

let g:workspace_session_disable_on_args = 1
let g:workspace_autosave = 0

let g:AutoPairsMultilineClose = 0

let g:mkdp_auto_close = 1

let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1

let mapleader = " "
let maplocalleader = ","

"" Conceal
let g:vim_json_syntax_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

"" Indent guides
lua << EOF
require("indent_blankline").setup {
    char = "│",
    buftype_exclude = {"terminal"},
    filetype_exclude = {"nerdtree"}
}
EOF

"" Telescope
lua <<EOF
local actions = require("telescope.actions")
require "telescope".setup {
    defaults = {
        preview = false,
        mappings = {
            i = {
                ["<esc>"] = actions.close
            }
        }
    }
}
EOF
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>

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
colorscheme nightfall

"" Operator highlight
let g:ophigh_color = 10
let g:ophigh_color_gui = "#e56750"

"" Statusline
let g:airline_theme = 'nightfall'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = '▙▚▚'
let g:airline_right_sep = '▞▞▟'
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.dirty='✗'
let g:airline_symbols.linenr = ' Ln:'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.colnr = ' Col:'

"" NerdCommenter
vmap \\ <plug>NERDCommenterToggle
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '//', 'right': '' } }

"" Coc
" use <c-space> for trigger completion
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
lua << EOF
require("toggleterm").setup{
  -- size can be a number or function which is passed the current terminal
  size = 20,
  direction = 'horizontal',
  shading_factor = '3'
}
EOF
nnoremap <silent> <C-t> :ToggleTerm<CR>
tnoremap <silent> <C-t> <C-\><C-N>:ToggleTerm<CR>

"" Nvim Tree
let g:nvim_tree_indent_markers = 1

lua << EOF
require'nvim-tree'.setup {
    auto_close = true,
    hijack_cursor = true,
    update_cwd = false,
    view = {
        width = 35,
        height = 35,
    }
}
EOF

nnoremap <C-b> :NvimTreeToggle<CR>

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
