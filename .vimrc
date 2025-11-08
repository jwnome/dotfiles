" Vim Configuration
" Converted from init.lua

" ============================================================================
" Basic Options
" ============================================================================
set number
set relativenumber
set wrap
set linebreak
set cursorline
set cursorcolumn

" Blinking cursor (terminal-dependent)
set guicursor=n-v-c-i:block-blinkon1

" ============================================================================
" Netrw (File Explorer)
" ============================================================================
" Toggle Netrw with Ctrl+e
nnoremap <silent> <C-e> :Lexplore<CR>

let g:netrw_winsize = 10
let g:netrw_banner = 0
let g:netrw_browse_split = 0
let g:netrw_altv = 1

" ============================================================================
" Buffer Navigation
" ============================================================================
" Next/previous buffer
nnoremap <silent> <C-n> :bnext<CR>
nnoremap <silent> <C-p> :bprev<CR>

" Delete buffer without closing window
nnoremap <silent> <leader>bd :bp<bar>sp<bar>bn<bar>bd<CR>

" Save and delete buffer (like :wq but keeps window)
nnoremap <silent> <leader>wq :w<CR>:bp<bar>sp<bar>bn<bar>bd<CR>

" ============================================================================
" Indentation & Tabs
" ============================================================================
set expandtab
set shiftwidth=4
set tabstop=4
set smartindent
set scrolloff=10

" ============================================================================
" Search Settings
" ============================================================================
set ignorecase
set smartcase

" ============================================================================
" Status Line
" ============================================================================
set laststatus=1

" ============================================================================
" Colors & Appearance
" ============================================================================
" Enable true color support (if terminal supports it)
if has('termguicolors')
  set termguicolors
endif

" Set default colorscheme
colorscheme lunaperche

" Force black background
set background=dark

" StatusLine colors
highlight StatusLine ctermfg=244 ctermbg=0 guifg=#808080 guibg=#000000
highlight StatusLineNC ctermfg=244 ctermbg=0 guifg=#808080 guibg=#000000
