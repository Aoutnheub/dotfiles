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
    Plug 'neoclide/coc.nvim', {'do': 'yarn install'}
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
    "Plug 'Aoutnheub/nightfall.vim'
    Plug 'Aoutnheub/omni-one.vim'
    Plug 'matze/vim-move'
    Plug 'dhruvasagar/vim-table-mode'
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'akinsho/toggleterm.nvim'
    Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
    Plug 'ollykel/v-vim'
    Plug 'rmagatti/auto-session'
    " Plug 'junegunn/rainbow_parentheses.vim'
    " Plug 'scalameta/nvim-metals'
call plug#end()

autocmd FileType python let b:coc_root_patterns = ['.git', '.env']
autocmd BufNewFile,BufRead *.frag,*.vert set ft=text | set syntax=c
autocmd BufNewFile,BufRead *.fs set ft=fsharp | set syntax=fsharp
autocmd BufNewFile,BufRead *.cshtml set ft=html
autocmd BufNewFile,BufRead *.clj,*.ex,*.exs setlocal tabstop=4 | setlocal shiftwidth=4

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

set rtp+=/home/aoutnheub/.opam/default/share/merlin/vim

" delete without yanking
nnoremap d "_d
vnoremap d "_d

" replace currently selected text with default register
" without yanking it
vnoremap p "_dP

" cut
nnoremap xx dd
vnoremap x d

"" Metals
" lua << EOF
" local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
" vim.api.nvim_create_autocmd("FileType", {
    " pattern = { "scala", "sbt" },
    " callback = function()
        " require("metals").initialize_or_attach({})
    " end,
    " group = nvim_metals_group,
" })
" EOF

"" Conceal
let g:vim_json_syntax_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

"" Indent guides
lua << EOF
require("indent_blankline").setup {
    char = "│",
    buftype_exclude = {"terminal"},
    filetype_exclude = {"NvimTree", "startify"}
}
EOF

""" Rainbow
" augroup rainbow_lisp
    " autocmd!
    " autocmd FileType lisp,clojure RainbowParentheses
" augroup END

" let g:rainbow#colors = {
" \   'dark': [
" \     ['1', '#e06c75'],
" \     ['3', '#d19a66'],
" \     ['6', '#e5c07b'],
" \     ['2', '#98c379'],
" \     ['4', '#56b6c2'],
" \     ['5', '#c678dd']
" \   ]
" \ }

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

"" Colorscheme
colorscheme omni_one

"" Operator highlight
let g:ophigh_color = 10
let g:ophigh_color_gui = "#e06c75"

"" Statusline
let g:airline_theme = 'omni_one'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.dirty='✗'
let g:airline_symbols.linenr = ' Ln:'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.colnr = ' Col:'

"" Bufferline
lua << EOF
require("bufferline").setup{
    options = {
        offsets = {{filetype = "NvimTree", text = "File Explorer" , text_align = "left"}},
        diagnostics = "coc",
        show_close_icon = false
    }
}
EOF
nnoremap <silent>b] :BufferLineCycleNext<CR>
nnoremap <silent>b[ :BufferLineCyclePrev<CR>
nnoremap <silent>bm] :BufferLineMoveNext<CR>
nnoremap <silent>bm[ :BufferLineMovePrev<CR>

"" NerdCommenter
vmap \\ <plug>NERDCommenterToggle
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDCustomDelimiters = {
    \ 'c': { 'left': '//', 'right': '' },
    \ 'odin': { 'left': '//', 'right': '' }
    \ }

"" Coc
nmap <silent> <C-c> <Plug>(coc-cursors-position)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gh :call ShowDocumentation()<CR>

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ CheckBackspace() ? "\<Tab>" :
    \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

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
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif

lua << EOF
require'nvim-tree'.setup {
    hijack_cursor = true,
    update_cwd = false,
    view = {
        width = 35,
        height = 35,
    },
    renderer = {
        indent_markers = {
            enable = true
        }
    },
    git = {
        ignore = false
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
