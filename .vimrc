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
