set fenc=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd

set wildmenu
set history=5000

set number
set cursorline
set cursorcolumn
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set laststatus=2
set wildmode=list:longest

set list listchars=tab:\▸\-
set expandtab
set tabstop=2
set shiftwidth=2

set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

" enable mouse scroll
if has('mouse')
  set mouse=a
  if has('mouse_sgr')
    set ttymouse=sgr
  elseif v:version > 703 || v:version is 703 && has('patch632')
    set ttymouse = sgr
  else
    set ttymouse=xterm2
  endif
endif

" smart paste from clipboard

" share clipboard
set clipboard=unnamedplus





" PLUGIN
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'      " nerdtree, nothing to say
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-github-dashboard'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'w0rp/ale'                 " lint
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'tomasr/molokai'           " status bar
Plug 'Valloric/YouCompleteMe'   " AutoComplete for C
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'     " fuzzing search
Plug 'ervandew/supertab'    " 
Plug 'sheerun/vim-polyglot' " Multi-lang pack
Plug 'jiangmiao/auto-pairs' " auto pair close
Plug 'terryma/vim-expand-region'    " change selected region
Plug 'simeji/winresizer'            " window conrol
Plug 'yuttie/comfortable-motion.vim' " confortable Ctf+F/B
Plug 'tyru/open-browser.vim'        " serarch in browser
call plug#end()

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" open-browser.vim
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
