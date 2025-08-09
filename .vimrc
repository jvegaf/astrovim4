" ============================================================================
" .vimrc - Comprehensive Vim Configuration
" Inspired by AstroNvim setup with modern features
" ============================================================================

" ============================================================================
" Basic Configuration
" ============================================================================

" Disable Vi compatibility
set nocompatible

" Enable filetype detection and plugins
if has('filetype')
  filetype indent plugin on
endif

" Enable syntax highlighting
if has('syntax')
  syntax on
endif

" Set leader keys (similar to your AstroNvim setup)
let mapleader = " "
let maplocalleader = ","

" ============================================================================
" Essential Options
" ============================================================================

" Display options
set number                    " Show line numbers
set relativenumber           " Show relative line numbers (like your config)
set signcolumn=yes           " Always show sign column
set wrap                     " Enable line wrapping
set showcmd                  " Show partial commands
set ruler                    " Show cursor position
set laststatus=2            " Always show status line
set cmdheight=2             " Set command window height

" Search options
set hlsearch                " Highlight search results
set incsearch               " Incremental search
set ignorecase              " Case insensitive search
set smartcase               " Smart case searching

" Edit behavior
set hidden                  " Allow switching between unsaved buffers
set autoindent              " Auto-indent new lines
set smartindent             " Smart indentation
set backspace=indent,eol,start " Allow backspacing over everything
set nostartofline           " Don't jump to start of line

" Indentation (4 spaces like modern editors)
set expandtab               " Use spaces instead of tabs
set tabstop=4               " Tab width
set shiftwidth=4            " Indentation width
set softtabstop=4           " Soft tab width

" File handling
set autoread                " Auto-reload changed files
set backup                  " Enable backups
set backupdir=~/.vim/backup " Backup directory
set directory=~/.vim/swap   " Swap file directory
set undofile                " Persistent undo
set undodir=~/.vim/undo     " Undo directory

" Create directories if they don't exist
if !isdirectory($HOME."/.vim/backup")
    call mkdir($HOME."/.vim/backup", "p")
endif
if !isdirectory($HOME."/.vim/swap")
    call mkdir($HOME."/.vim/swap", "p")
endif
if !isdirectory($HOME."/.vim/undo")
    call mkdir($HOME."/.vim/undo", "p")
endif

" Completion
set wildmenu                " Enhanced command line completion
set wildmode=longest:full,full
set completeopt=menuone,noinsert,noselect

" Visual settings
set visualbell              " Visual bell instead of beeping
set t_vb=                   " Disable visual bell
set confirm                 " Confirm instead of failing commands
set scrolloff=8             " Keep 8 lines above/below cursor
set sidescrolloff=8         " Keep 8 columns left/right of cursor

" Performance
set updatetime=300          " Faster completion
set timeoutlen=500          " Key mapping timeout
set ttimeoutlen=50          " Key code timeout

" Mouse support
if has('mouse')
  set mouse=a
endif

" ============================================================================
" Key Mappings (Based on your AstroNvim config)
" ============================================================================

" Save file
nnoremap <leader>w :w<CR>
nnoremap W :w<CR>

" Quit
nnoremap <leader>q :quit<CR>

" Select all
nnoremap <C-a> ggVG

" Clear search highlighting
nnoremap <Esc> :nohlsearch<Bar>:echo<CR>

" Split navigation (similar to your setup)
nnoremap ss :split<CR>
nnoremap sv :vsplit<CR>
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l

" Smart window navigation
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Buffer navigation (like your AstroNvim)
nnoremap L :bnext<CR>
nnoremap H :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap [b :bprevious<CR>

" Close buffer
nnoremap Q :bdelete<CR>

" Move lines up/down
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

" Visual mode improvements
vnoremap < <gv
vnoremap > >gv
vnoremap p "_dP
xnoremap p "_dP

" Visual mode line selection
nnoremap vv V

" Jump improvements
nnoremap <C-m> <C-i>

" File operations
nnoremap <leader>e :Explore<CR>

" Search and replace
nnoremap <leader>s :%s/
vnoremap <leader>s :s/

" Toggle paste mode
set pastetoggle=<F11>

" Copy to system clipboard
vnoremap <leader>y "+y
nnoremap <leader>y "+y

" Paste from system clipboard
nnoremap <leader>p "+p
vnoremap <leader>p "+p

" ============================================================================
" Insert Mode Mappings
" ============================================================================

" Quick bracket pairs
inoremap {<CR> {<CR>}<Esc>ko
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i

" Leave insert mode
inoremap jk <Esc>
inoremap kj <Esc>

" ============================================================================
" Command Line Mappings
" ============================================================================

" Bash-like navigation
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" ============================================================================
" Auto Commands
" ============================================================================

augroup GeneralSettings
  autocmd!

  " Go to last cursor position when opening a file
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

  " Remove trailing whitespace on save
  autocmd BufWritePre * %s/\s\+$//e

  " Disable auto-commenting
  autocmd BufEnter * set formatoptions-=cro

  " Set paste mode when entering insert mode with clipboard
  autocmd InsertLeave * set nopaste

  " File type specific settings
  autocmd FileType json,jsonc,markdown setlocal conceallevel=0
  autocmd FileType help wincmd L
  autocmd FileType html,css,javascript,typescript setlocal shiftwidth=2 softtabstop=2
  autocmd FileType python setlocal shiftwidth=4 softtabstop=4

augroup END

" ============================================================================
" Color Scheme and Appearance
" ============================================================================

" Set color scheme
set background=dark
if has('termguicolors')
  set termguicolors
endif

" Try to set a nice color scheme
try
  colorscheme desert
catch
  colorscheme default
endtry

" Status line configuration
set statusline=%f%m%r%h%w\ [%Y]\ [%{&ff}]\ %=%l,%c\ %p%%

" ============================================================================
" File Type Settings
" ============================================================================

augroup FileTypeSettings
  autocmd!

  " Web development
  autocmd FileType html,css,scss,javascript,typescript,jsx,tsx setlocal shiftwidth=2 softtabstop=2

  " Programming languages
  autocmd FileType python setlocal shiftwidth=4 softtabstop=4
  autocmd FileType java setlocal shiftwidth=4 softtabstop=4
  autocmd FileType cpp,c setlocal shiftwidth=4 softtabstop=4

  " Configuration files
  autocmd FileType yaml,yml setlocal shiftwidth=2 softtabstop=2
  autocmd FileType json setlocal shiftwidth=2 softtabstop=2

augroup END

" ============================================================================
" Search and Replace Enhancements
" ============================================================================

" Visual selection search
vnoremap * y/\V<C-r>=escape(@",'/\')<CR><CR>
vnoremap # y?\V<C-r>=escape(@",'/\')<CR><CR>

" Search for visually selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" ============================================================================
" Folding
" ============================================================================

set foldmethod=indent
set foldlevelstart=99
set foldenable

" ============================================================================
" Plugin-like Functions (Emulating some AstroNvim features)
" ============================================================================

" Function to toggle relative numbers
function! ToggleRelativeNumber()
  if &relativenumber
    set norelativenumber
  else
    set relativenumber
  endif
endfunction
nnoremap <leader>ur :call ToggleRelativeNumber()<CR>

" Function to format file
function! FormatFile()
  let l:save_pos = getpos('.')
  normal! gg=G
  call setpos('.', l:save_pos)
endfunction
nnoremap gq :call FormatFile()<CR>

" Function to create new files
function! CreateFile(filename)
  execute 'edit ' . a:filename
endfunction
command! -nargs=1 NewFile call CreateFile(<q-args>)

" ============================================================================
" Terminal Configuration (Vim 8+)
" ============================================================================

if has('terminal')
  " Terminal mappings
  tnoremap <Esc> <C-\><C-n>
  tnoremap <M-1> <C-\><C-n>:terminal ++rows=10<CR>
  nnoremap <M-1> :terminal ++rows=10<CR>
  nnoremap <M-2> :terminal ++rows=20<CR>
  nnoremap <M-4> :vertical terminal<CR>
endif

" ============================================================================
" Simple File Explorer Enhancement
" ============================================================================

" Enhance netrw (built-in file explorer)
let g:netrw_banner = 0          " Remove banner
let g:netrw_liststyle = 3       " Tree style
let g:netrw_browse_split = 4    " Open in previous window
let g:netrw_winsize = 25        " 25% width
let g:netrw_altv = 1           " Open splits to the right

" ============================================================================
" Performance Optimizations
" ============================================================================

" Disable some built-in plugins for better performance
let g:loaded_gzip = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:loaded_rrhelper = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1

" ============================================================================
" Error Handling and Diagnostics Simulation
" ============================================================================

" Simple error navigation
nnoremap ]e :cnext<CR>
nnoremap [e :cprevious<CR>
nnoremap <leader>xx :copen<CR>
nnoremap <leader>xc :cclose<CR>

" ============================================================================
" Additional Quality of Life Features
" ============================================================================

" Highlight current line in active window only
augroup CursorLine
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" Auto-save when focus is lost
autocmd FocusLost * silent! wa

" Remember cursor position
augroup RememberCursor
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

" ============================================================================
" Spell Checking
" ============================================================================

" Spell checking mappings
nnoremap <leader>ss :setlocal spell!<CR>
nnoremap <leader>sn ]s
nnoremap <leader>sp [s
nnoremap <leader>sa zg
nnoremap <leader>s? z=

" ============================================================================
" Window Management
" ============================================================================

" Window resizing
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>

" ============================================================================
" System Integration
" ============================================================================

" System clipboard integration
if has('clipboard')
  set clipboard=unnamedplus
endif

" WSL clipboard support (similar to your polish.lua)
if system('uname -r') =~ 'microsoft'
  augroup WSLYank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call system('clip.exe', @0) | endif
  augroup END
endif

" ============================================================================
" Session Management
" ============================================================================

" Session options
set sessionoptions=buffers,curdir,folds,help,tabpages,winsize,winpos,terminal

" Quick session save/load
nnoremap <leader>zs :mksession! ~/.vim/session.vim<CR>
nnoremap <leader>zr :source ~/.vim/session.vim<CR>

" ============================================================================
" Final Configuration
" ============================================================================

" Source local vimrc if it exists
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

" Load project-specific vimrc
if filereadable('.vimrc.local')
  source .vimrc.local
endif

" ============================================================================
" Tips and Usage Notes
" ============================================================================
"
" This .vimrc provides functionality similar to your AstroNvim configuration:
"
" Key Features:
" - Leader key: Space (like AstroNvim)
" - Local leader: , (comma)
" - Buffer navigation: H/L for prev/next buffer
" - Window management: sh/sj/sk/sl for navigation
" - File operations: <leader>e for explorer
" - Clipboard integration with system
" - Modern editing features like relative numbers
"
" Main Mappings:
" - <Space>w : Save file
" - <Space>q : Quit
" - <Space>e : File explorer
" - H/L : Previous/Next buffer
" - ss/sv : Horizontal/Vertical split
" - <Esc> : Clear search highlight
" - jk/kj : Exit insert mode
"
" To extend this configuration:
" 1. Create ~/.vimrc.local for personal additions
" 2. Use :help <topic> to learn more about any setting
" 3. Install vim-plug or pathogen for plugin management
"
" ============================================================================

echo "Comprehensive .vimrc loaded successfully!"
