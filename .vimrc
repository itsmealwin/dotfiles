" Good-bye VI
set nocompatible

" With a map leader it's possible to do extra key combinations
let mapleader = ","
let g:mapleader = ","

" Can NOT live without this
syntax on

" Help me indent
set autoindent
" Better background for vim
set background=dark

" Best colorscheme for my eyes
colorscheme gruvbox
" How can anyone not wrap texts
set wrap
" Wrap at convenient points
set linebreak
" Dont continue comments when pushing o/O
set formatoptions-=o

" Much better status bar
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = '>>'
let g:airline#extensions#tabline#left_alt_sep = '>'
let g:airline_theme='bubblegum'
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#quickfix#enabled = 0
let g:airline#extensions#eclim#enabled = 0
let g:airline#extensions#netrw#enabled = 0

" Disable mouse
set mouse=

" Include click syntax highlighting
augroup filetypedetect
    au BufNewFile,BufRead *.click set filetype=click syntax=click
augroup END

" Never use Esc key anymore
inoremap <esc> <nop>
inoremap jk <esc>
inoremap <c-c> <esc>

" Faster Ex-mode
nnoremap : ;
nnoremap ; :

"Make Y yank to end of line (like D, or C)
nmap Y y$

" Paste from system's clipboard
nnoremap cv "*p
nnoremap cV "*P

" Delete the line above the cursor except the line of the cursor
nnoremap dK kdd
" Delete the line below the cursor except the line of the cursor
nnoremap dJ jddk

" Reselect pasted text. Mnem: 'Get pasted'
nnoremap gp `[v`]

" Go to position of last edit. Mnem: 'Go to Edit'
nnoremap ge `.

" Always start visual LINE mode
nnoremap v V
nnoremap V v
vnoremap v V
vnoremap V v

" Enable intuitive moving on wrapped lines
nmap j gj
nmap k gk

" move to beginning/end of line
nnoremap B ^
vnoremap B ^
nnoremap E $
vnoremap E ^

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" Enable true color
set t_Co=256

" Set tab to 4 whitespaces
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set smarttab

" enable all Python syntax highlighting features
let python_highlight_all = 1

" show a visual line under the cursor's current line
set cursorline

" Show line number but also relative line number
set ruler
set relativenumber
set number

" Ignore case when searching
set ignorecase
set smartcase

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Resize panes
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left> :vertical resize -5<cr>
nnoremap <silent> <Up> :resize +5<cr>
nnoremap <silent> <Down> :resize -5<cr>

" Use tab to jump between blocks, because it's easier
nnoremap <tab> %
vnoremap <tab> %

" Update dir to current file
autocmd BufEnter * silent! cd %:p:h

" Always use vertical diffs
set diffopt+=vertical

" Auto resize Vim splits to active split
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

set guioptions-=m " Disable menu bar
set guioptions-=T " Disable toolbar
set guioptions-=r " Disable right-hand scroll bar
set guioptions-=R " Disable right-hand scroll bar
set guioptions-=l " Disable left-hand scroll bar
set guioptions-=L " Disable left-hand scroll bar
set guioptions-=b " Disable bottom-hand scroll bar

" Folding settings
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

" Enabling filetype options
filetype on
filetype plugin on
filetype indent on

" Skip scanning the usr/include files, they are large
set complete-=i

" Highlight search
set hlsearch
set incsearch

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Press CTRL-Space for completion in insert mode
imap <c-Space> <c-x><c-u>
imap <c-@> <c-x><c-u>

" Activate Vim addon manager
set runtimepath+=/Users/alwin/.vim/vim-addons
call vam#ActivateAddons([ "vim-airline", "vim-surround", "autoswap", "tagbar", "delimmate", "vim-repeat", "vim-unimpaired", "vim-commentary", "fzf"],{'auto_install' : 0})

" FZF in vim
set rtp+=/usr/local/opt/fzf
let g:fzf_layout = { 'down': '~40%' }

" Command line abbrevation for tabnew
ca tn tabnew
" NERRRRDDD
ca Nt NERDTree

" Set hidden buffers
set hidden

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
" Remember info about open buffers on close
set viminfo^=%

" Always show status line
set laststatus=2
set nojoinspaces
set showmatch
" Select all lines in the file
map <c-a> ggVG
set cmdheight=2

" Persistent undo
let undodir = expand('~/.undo-vim')
if !isdirectory(undodir)
  call mkdir(undodir)
endif
set undodir=~/.undo-vim
set undofile " Create FILE.un~ files for persistent undo

" My vim is smarter than me
set history=1000
set undolevels=100

" Write for me, vim!
set autowrite
" Set to auto read when a file is changed from the outside
set autoread

" Fast saving
nnoremap <leader>w :w!<cr>
" Quickly close windows
nnoremap <leader>x :x<cr>

" Quickly open vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" Quickly source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" Use fzf for the win
nnoremap <leader>ff :FZF<cr>
nnoremap <leader>fg :GitFiles<cr>
nnoremap <leader>fw :Windows<cr>
nnoremap <leader>fc :Commands<cr>
nnoremap <leader>fb :Buffers<cr>

" Open new buffer in current window
nnoremap <leader>ee :ene<cr>

" Eclim java
nnoremap <leader>jr :JavaRename<space>
nnoremap <leader>jc :JavaCorrect<cr>
nnoremap <silent> <leader>jf :%JavaFormat<cr>
nnoremap <silent> <leader>ji :JavaImportOrganize<cr>
nnoremap <silent> <leader>jv :JavaValidate<cr>
nnoremap <silent> <leader>jh :JavaCallHierarchy<cr>
nnoremap <silent> <leader>jp :PingEclim<cr>
nnoremap <silent> <leader>jx :ShutdownEclim<cr>

" Tagbar
nnoremap <leader>tb :TagbarToggle<CR>
" Use pretty arrows
let g:tagbar_usearrows = 1
" Better R support
let g:tagbar_type_r = {
        \ 'ctagstype' : 'r',
        \ 'kinds'     : [
            \ 'f:Functions',
            \ 'g:GlobalVariables',
            \ 'v:FunctionVariables',
        \ ]
    \ }

" Quickly open a second window to view files side by side
nnoremap <leader>vn :vsplit<cr>
nnoremap <leader>vs :vsplit<cr>

" Use custom ignore to exlude directories and certain files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class

" Spell checking
setglobal spell spelllang=en_gb
" By default spelling is off ...
set nospell
" ...but enable it for the English text files I use a lot.
au BufRead,BufNewFile,BufWrite *.txt,*.tex,*.latex set spell

" Something to do with matches
set mat=2

" Stop ringing my bell
set visualbell

" Enables backspace to delete over lines
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" I hate scratch preview
set completeopt-=preview

" Set the vim encoding
set encoding=utf8
set ffs=unix,dos,mac

" Automatically remove all trailing whitespaces
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

set listchars=tab:»·,trail:·
set list
set title
set title titlestring=

" Keep cursor in the middle of the screen if possible
set scrolloff=500
" Also don't scroll until the end of the screen if possible
set sidescrolloff=20
set sidescroll=1

" Slightly faster scrolling
nnoremap <C-e> 3j
nnoremap <C-y> 3k

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Completely disable mouse scrolling
imap <ScrollWheelUp> <nop>
imap <S-ScrollWheelUp> <nop>
imap <C-ScrollWheelUp> <nop>
imap <ScrollWheelDown> <nop>
imap <S-ScrollWheelDown> <nop>
imap <C-ScrollWheelDown> <nop>
imap <ScrollWheelLeft> <nop>
imap <S-ScrollWheelLeft> <nop>
imap <C-ScrollWheelLeft> <nop>
imap <ScrollWheelRight> <nop>
imap <S-ScrollWheelRight> <nop>
imap <C-ScrollWheelRight> <nop>

vmap <ScrollWheelUp> <nop>
vmap <S-ScrollWheelUp> <nop>
vmap <C-ScrollWheelUp> <nop>
vmap <ScrollWheelDown> <nop>
vmap <S-ScrollWheelDown> <nop>
vmap <C-ScrollWheelDown> <nop>
vmap <ScrollWheelLeft> <nop>
vmap <S-ScrollWheelLeft> <nop>
vmap <C-ScrollWheelLeft> <nop>
vmap <ScrollWheelRight> <nop>
vmap <S-ScrollWheelRight> <nop>
vmap <C-ScrollWheelRight> <nop>

nmap <ScrollWheelUp> <nop>
nmap <S-ScrollWheelUp> <nop>
nmap <C-ScrollWheelUp> <nop>
nmap <ScrollWheelDown> <nop>
nmap <S-ScrollWheelDown> <nop>
nmap <C-ScrollWheelDown> <nop>
nmap <ScrollWheelLeft> <nop>
nmap <S-ScrollWheelLeft> <nop>
nmap <C-ScrollWheelLeft> <nop>
nmap <ScrollWheelRight> <nop>
nmap <S-ScrollWheelRight> <nop>
nmap <C-ScrollWheelRight> <nop>
