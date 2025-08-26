" =============================================================================
" Base Vim Configuration (.vimrc)
" =============================================================================

" General Settings
" -----------------------------------------------------------------------------
set nocompatible                " Disable vi compatibility
set encoding=utf-8              " Set default encoding
set fileencoding=utf-8          " File encoding
set backspace=indent,eol,start  " Allow backspace over everything
set history=1000                " Command history length
set undolevels=1000             " Undo history length

" Display Settings  
" -----------------------------------------------------------------------------
syntax on                       " Enable syntax highlighting
set number                      " Show line numbers
set relativenumber              " Show relative line numbers
set ruler                       " Show cursor position
set showcmd                     " Show command in status line
set showmatch                   " Highlight matching brackets
set matchtime=2                 " Bracket highlight duration
set laststatus=2                " Always show status line
set cursorline                  " Highlight current line
set wrap                        " Wrap long lines
set linebreak                   " Break lines at word boundaries
set showbreak=↪\                " Visual indicator for wrapped lines

" Color and Theme
" -----------------------------------------------------------------------------
set background=dark             " Use dark background
colorscheme default             " Use default colorscheme
set t_Co=256                    " Enable 256 colors

" Indentation and Formatting
" -----------------------------------------------------------------------------
set autoindent                  " Auto-indent new lines
set smartindent                 " Smart indentation
set tabstop=4                   " Tab width
set shiftwidth=4                " Indent width
set softtabstop=4               " Soft tab width
set expandtab                   " Convert tabs to spaces
set smarttab                    " Smart tab behavior

" Search Settings
" -----------------------------------------------------------------------------
set hlsearch                    " Highlight search results
set incsearch                   " Incremental search
set ignorecase                  " Case-insensitive search
set smartcase                   " Case-sensitive if uppercase present
set wrapscan                    " Wrap search around file

" File and Buffer Management
" -----------------------------------------------------------------------------
set hidden                      " Allow hidden buffers
set autoread                    " Auto-reload changed files
set backup                      " Enable backups
set backupdir=~/.vim/backup//   " Backup directory
set directory=~/.vim/swap//     " Swap file directory
set undofile                    " Enable persistent undo
set undodir=~/.vim/undo//       " Undo directory

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

" Window and Split Management
" -----------------------------------------------------------------------------
set splitbelow                  " Open horizontal splits below
set splitright                  " Open vertical splits to the right
set winminheight=0              " Minimum window height
set winminwidth=0               " Minimum window width

" Performance and Behavior
" -----------------------------------------------------------------------------
set lazyredraw                  " Don't redraw during macros
set ttyfast                     " Fast terminal connection
set timeoutlen=500              " Key sequence timeout
set updatetime=300              " Faster completion
set shortmess+=c                " Don't show completion messages

" Wildmenu (Command Completion)
" -----------------------------------------------------------------------------
set wildmenu                    " Enable command-line completion
set wildmode=list:longest,full  " Completion behavior
set wildignore=*.o,*~,*.pyc     " Ignore compiled files
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

" Key Mappings
" -----------------------------------------------------------------------------
" Set leader key
let mapleader = " "

" Quick save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

" Clear search highlighting
nnoremap <leader>/ :nohlsearch<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize windows with arrows
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>

" Buffer navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

" Quick edit vimrc
nnoremap <leader>ev :edit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Toggle line numbers
nnoremap <leader>n :set number!<CR>

" Insert mode shortcuts
inoremap jk <Esc>
inoremap kj <Esc>

" Move lines up/down in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Auto Commands
" -----------------------------------------------------------------------------
augroup BaseConfig
    autocmd!
    " Return to last edit position when opening files
    autocmd BufReadPost *
         \ if line("'\"") > 0 && line("'\"") <= line("$") |
         \   exe "normal! g`\"" |
         \ endif
    
    " Remove trailing whitespace on save
    autocmd BufWritePre * :%s/\s\+$//e
    
    " Highlight text beyond 80 characters
    autocmd FileType * highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    autocmd FileType * match OverLength /\%81v.\+/
augroup END

" Status Line Configuration
" -----------------------------------------------------------------------------
set statusline=
set statusline+=%f              " File path
set statusline+=%m              " Modified flag
set statusline+=%r              " Readonly flag
set statusline+=%h              " Help buffer flag
set statusline+=%w              " Preview window flag
set statusline+=%=              " Right align from here
set statusline+=%y              " File type
set statusline+=\ [%{strlen(&fenc)?&fenc:'none'}] " File encoding
set statusline+=\ %l/%L         " Line number/total lines
set statusline+=\ %c            " Column number
set statusline+=\ %P            " Percentage through file
