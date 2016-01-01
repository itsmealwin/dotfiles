"                 8h
"                 ""
"    8b       d8  88  88,dPYba,,adPYba,   8b,dPPYba,   ,adPPYba,
"    `8b     d8'  88  88P'   "88"    "8a  88P'   "Y8  a8"     ""
"     `8b   d8'   88  88      88      88  88          8b
"      `8b,d8'    88  88      88      88  88          "8a,   ,aa
"        "8"      88  88      88      88  88           `"Ybbd8"'
"

" Good-bye VI
set nocompatible

" With a map leader it's possible to do extra key combinations
let mapleader   = " "
let g:mapleader = " "

" Can NOT live without this
syntax on
" Don't highlight past certain length; slows down vim on long lines
set synmaxcol=150

" Help me indent
set autoindent
" Better background for vim
set background=light

" Best colorscheme for my eyes
colorscheme gruvbox
" Even better gruvbox
let g:gruvbox_contrast_dark = 'hard'
" Solarized settings so that it actually works
let g:solarized_termcolors  = 256

" Apparently there is a security issue with modelines
set modelines=0
" How can anyone not wrap texts
set wrap
" Wrap at convenient points
set linebreak
" String to put before wrapped screen lines
set showbreak=↪\ \
" Show last line, even if it doesn't fit in the window
set display+=lastline
" Dont update viewport until the marco has completed for faster processing.
set lazyredraw
" To show pages using `more` in command outputs.
set more
" Don't jump my cursor around without my permission!
set nostartofline
" A little bit more time for macros
set timeoutlen=400
" Make Esc work faster
set ttimeoutlen=30
" Don't save global options. These should be set in vimrc
set sessionoptions-=options

" Recognize numbered lists
set formatoptions+=n
" Use indent from 2nd line of a paragraph
set formatoptions+=2
" Don't break lines that are already long
set formatoptions+=l
" Break before 1-letter words
set formatoptions+=1
" Delete comment character when joining commented lines, so two lines of comment becomes one line when joining, without comment mark.
if v:version + has("patch541") >= 704
    set formatoptions+=j
endif
" Don't continue comment mark after press 'o' when youre on a commented line
set formatoptions -=cro
" See the help under formatoptions for details
set formatoptions =tqw

" More intelligent tag finding
set tags=./tags,tags;

" Disable mouse
set mouse=
" Don't use octal, vim
set nrformats="alpha"

" Never use Esc key anymore
inoremap <esc> <esc>
inoremap jk    <esc>
inoremap <c-c> <Esc><Esc>
" When I forget I'm in Insert mode, how often do you type 'jj' anyway?:
inoremap jj    <Esc>

"Make Y yank to end of line (like D, or C)
nmap Y y$

" Copy to clipboard, http://news.ycombinator.com/item?id=4767227 , use 3 \y to copy 3 lines
nnoremap <leader>y "*y
vnoremap <leader>y "*y
" Paste from clipboard
nnoremap <leader>p "*p
nnoremap <leader>P "*P

" Delete the line above the cursor except the line of the cursor
nnoremap dK mzkdd`z
" Delete the line below the cursor except the line of the cursor
nnoremap dJ mzjddk`z
" Reselect pasted text. Mnem: 'Get pasted'
nnoremap vp `[v`]
" Go to position of last edit. Mnem: 'Go to Edit'
nnoremap ge `.
" Do C-] but open in new vertical split
nnoremap <c-\> <c-w>v<c-]>zvzz

" Motion for "next/last object". For example, "dinb" would go to the next "()" pair
" and delete its contents contents and andp andp
onoremap an :<c-u>call <SID>NextTextObject('a', 'f')<cr>
xnoremap an :<c-u>call <SID>NextTextObject('a', 'f')<cr>
onoremap in :<c-u>call <SID>NextTextObject('i', 'f')<cr>
xnoremap in :<c-u>call <SID>NextTextObject('i', 'f')<cr>
onoremap al :<c-u>call <SID>NextTextObject('a', 'F')<cr>
xnoremap al :<c-u>call <SID>NextTextObject('a', 'F')<cr>
onoremap il :<c-u>call <SID>NextTextObject('i', 'F')<cr>
xnoremap il :<c-u>call <SID>NextTextObject('i', 'F')<cr>
function! s:NextTextObject(motion, dir)
  let c = nr2char(getchar())

  if c ==# "b"
      let c = "("
  elseif c ==# "B"
      let c = "{"
  elseif c ==# "d"
      let c = "["
  endif

  exe "normal! ".a:dir.c."v".a:motion.c
endfunction

" Quicker text objects
onoremap iq i"
onoremap aq a"
onoremap iQ i'
onoremap aQ a'
onoremap ic i{
onoremap ac a{
onoremap iC i[
onoremap aC a[

" A function to delete all trailing whitespace from a file. (From
" http://vimcasts.org/episodes/tidying-whitespace/)
function! <SID>DeleteTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
nnoremap <f5> :call <SID>DeleteTrailingWhitespace()<cr>

" Always start visual LINE mode
nnoremap v <c-v>
vnoremap v <c-v>

" Enable intuitive moving on wrapped lines
nmap j gj
nmap k gk

" Move to beginning/end of line
nnoremap B ^
vnoremap B ^
nnoremap E $
vnoremap E ^

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" Q to replay the marco.
nnoremap Q @q

" Enable true color
let base16colorspace=256
set t_Co=256

" Set tab to 4 whitespaces
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set smarttab
set shiftround

" Enable all Python syntax highlighting features
let python_highlight_all = 1

" Show line number but also relative line number
set ruler
set relativenumber
set number
set numberwidth=5

" Ignore case when searching
set ignorecase
set smartcase
" Ignore case on insert completion
set infercase

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Resize panes
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left>  :vertical resize -5<cr>
nnoremap <silent> <Up>    :resize +5<cr>

" Use tab to jump between blocks, because it's easier
nnoremap <tab> %
vnoremap <tab> %

" Go to the end of pasted text, easier to spam paste
nnoremap p p`]

" Put text from default register under/over current line
nnoremap <silent> <leader>pj :pu<CR>`[=`]
nnoremap <silent> <leader>pk :pu!<CR>`[=`]

" Duplicate the selection
vnoremap D y`]pgv

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
" Make regex more sane
nnoremap :s/ :s/\v

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <Space> :nohlsearch<Bar>:echo<CR>

" Press CTRL-Space for completion in insert mode
imap <c-Space> <c-x><c-o>
imap <c-@>     <c-x><c-o>

" Set hidden buffers
set nohidden

function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Return to last edit position when opening files (You want this!)
augroup IntelligentVim
    autocmd!
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif
    " Automatically delete trailing white spaces
    autocmd BufWrite * :call <SID>StripTrailingWhitespaces()
augroup END
" Remember info about open buffers on close
set viminfo^=%

" Let me have fast vim please
set ttyfast
" Always show status line
set laststatus=2
set nojoinspaces
set showmatch
set noshowmode
set cmdheight=1

" Persistent undo
let undodir = expand('~/.undo-vim')
if !isdirectory(undodir)
  call mkdir(undodir)
endif
set undodir=~/.undo-vim
set undofile
" My vim is smarter than me
set history=10000
set undolevels=100000
" number of undo lines to save
set undoreload=100000
" More undo points
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u

" Set to auto-read when a file is changed from the outside
set autoread
set autowrite

" Fast saving
nnoremap <leader><leader>   :w<cr>
inoremap <c-s>              <esc>:w<cr>
" Quickly close windows
nnoremap <leader>x          :x<cr>
nnoremap <leader>q          :q<cr>
nnoremap <leader>Q          :q!<cr>
" Quickly close buffer
nnoremap <silent><leader>bb :bd<cr>
" New tab quickly
nnoremap <leader>tt         :tabnew<cr>
" Close tab quickly
nnoremap <leader>tq         :tabclose<cr>

" Quickly open vimrc
nnoremap <Leader>vv :vsplit $MYVIMRC<cr>
" Quickly source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>
" Open new buffer in current window
nnoremap <leader>ee :ene<cr>
" Quickly open a second window to view files side by side
nnoremap <leader>vs :vsplit<cr>

" Quickly move between panes
vnoremap <c-h> <c-w>hzz
vnoremap <c-j> <c-w>jzz
vnoremap <c-k> <c-w>kzz
vnoremap <c-l> <c-w>lzz
nnoremap <c-h> <c-w>hzz
nnoremap <c-j> <c-w>jzz
nnoremap <c-k> <c-w>kzz
nnoremap <c-l> <c-w>lzz

" Quick cd
cabbrev <silent> acs    cd ~/Documents/WorkspaceDaiAcs/acs/trunk
cabbrev <silent> distal cd ~/Documents/Uni/Masterstudium/DistributedAlgorithms/WorkspaceDistributedAlgorithm
cabbrev <silent> wlab   cd ~/Documents/Uni/Masterstudium/WirelessLab/WorkspaceWirelessLab
cabbrev <silent> cfish  vsplit ~/.config/fish/config.fish
cabbrev <silent> tconf  vsplit ~/.tmux.conf

" Use custom ignore to exlude directories and certain files
set wildignore+=*/tmp/*,*.so,*.swp
set wildignore+=*.zip,*.rar,*.tar.gz
set wildignore+=*.jar,*.class,*/target/,*.xmi
set wildignore+=*.network,*.pdict
set wildignore+=*.svn,*.git
set wildignore+=*.jpg,*.bmp,*.png,*.jpeg,*.mp4,*.avi
set wildignore+=*.pdf,*.aux,*.toc

" Spell checking
setglobal spell spelllang=en_gb
" By default spelling is off ...
set nospell

" Highlight matching brackets for 2/10 of second
set mat=2

" Stop ringing my bell
set visualbell

" Enables backspace to delete over lines
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" I hate scratch preview
set completeopt-=preview

" Better completion
set completeopt+=longest
set completeopt+=menuone

" Set the vim encoding
if(has('vim'))
    set encoding=utf8
endif
set ffs=unix,dos,mac

set listchars=tab:»·,trail:·
set nolist
set title

" Keep cursor in the middle of the screen if possible
set scrolloff=3
" Also don't scroll until the end of the screen if possible
set sidescrolloff=20
set sidescroll=1

" Slightly faster scrolling
nnoremap <c-e>         6<c-e>
vnoremap <c-e>         6<c-e>
nnoremap <c-y>         6<c-y>
vnoremap <c-y>         6<c-y>
nnoremap 9             {zz
vnoremap 9             {zz
nnoremap 0             }zz
vnoremap 0             }zz
nnoremap <silent><f9>  3{zz
vnoremap <silent><f9>  3{zz
nnoremap <silent><f10> 3}zz
vnoremap <silent><f10> 3}zz

" Center the screen around what I searched for
nnoremap G Gzz
nnoremap <c-d> <c-d>zz
nnoremap <c-u> <c-u>zz
" Also center for quickfix-list
nnoremap ]c ]czz
nnoremap [c [czz

" Since we have clever-f, the ; command is now free
nnoremap ; :
nnoremap <leader>; ;
nnoremap : ;
vnoremap ; :
vnoremap <leader>; ;
vnoremap : ;
" Create newlines without entering insert mode
nnoremap go o<Esc>k
nnoremap gO O<Esc>j
" remap U to <C-r> for easier redo
" from http://vimbits.com/bits/356
nnoremap U <C-r>

" split line
nnoremap K i<cr><esc>

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" Reselect visual block after indenting
vnoremap < <gv
vnoremap > >gv

" Generate tags
nnoremap <silent><f1> :!ctags -R .<cr>

" Fix Cursor in TMUX
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=3\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=2\x7"
  let &t_SR = "\<Esc>]50;CursorShape=3\x7"
endif

" Some personal utilities
nnoremap <leader>= mzyypVr=`zPVr=`z
nnoremap <leader>- mzyypVr-`zPVr-`z

" Menu completion on command via <tab>
set wildmenu
" First list the available options and complete the longest common part, then have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full
" Please ignore case when giving me suggestion
set wildignorecase

" Backups
set backupdir=~/.backup-vim
set directory=~/.backup-vim
set noswapfile

" Continuous line
noremap <silent><leader>sb :<c-u>let @z=&so<cr>:set so=0 noscb<cr>:bo vs<cr>Ljzt:setl scb<cr><c-w>p:setl scb<cr>:let &so=@z<cr>

" Completely disable mouse scrolling
imap <ScrollWheelUp>      <nop>
imap <S-ScrollWheelUp>    <nop>
imap <C-ScrollWheelUp>    <nop>
imap <ScrollWheelDown>    <nop>
imap <S-ScrollWheelDown>  <nop>
imap <C-ScrollWheelDown>  <nop>
imap <ScrollWheelLeft>    <nop>
imap <S-ScrollWheelLeft>  <nop>
imap <C-ScrollWheelLeft>  <nop>
imap <ScrollWheelRight>   <nop>
imap <S-ScrollWheelRight> <nop>
imap <C-ScrollWheelRight> <nop>
vmap <ScrollWheelUp>      <nop>
vmap <S-ScrollWheelUp>    <nop>
vmap <C-ScrollWheelUp>    <nop>
vmap <ScrollWheelDown>    <nop>
vmap <S-ScrollWheelDown>  <nop>
vmap <C-ScrollWheelDown>  <nop>
vmap <ScrollWheelLeft>    <nop>
vmap <S-ScrollWheelLeft>  <nop>
vmap <C-ScrollWheelLeft>  <nop>
vmap <ScrollWheelRight>   <nop>
vmap <S-ScrollWheelRight> <nop>
vmap <C-ScrollWheelRight> <nop>
nmap <ScrollWheelUp>      <nop>
nmap <S-ScrollWheelUp>    <nop>
nmap <C-ScrollWheelUp>    <nop>
nmap <ScrollWheelDown>    <nop>
nmap <S-ScrollWheelDown>  <nop>
nmap <C-ScrollWheelDown>  <nop>
nmap <ScrollWheelLeft>    <nop>
nmap <S-ScrollWheelLeft>  <nop>
nmap <C-ScrollWheelLeft>  <nop>
nmap <ScrollWheelRight>   <nop>
nmap <S-ScrollWheelRight> <nop>
nmap <C-ScrollWheelRight> <nop>

" :grep foo *.js
set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column\ --vimgrep
set grepformat=%f:%l:%c:%m
" :Grep foo
" :LGrep bar
command! -nargs=+ -complete=file_in_path -bar Grep  silent! grep! <args> | redraw!
command! -nargs=+ -complete=file_in_path -bar LGrep silent! lgrep! <args> | redraw!

" ==========================
" NEOVIM specific settings
" ==========================

if has('nvim')

    " Fix the pane switching
    nnoremap <BS> <c-w>hzz
    vnoremap <BS> <c-w>hzz

    " Self explanatory
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

endif

" ===============
" PLUGIN SETTINGS
" ===============

" Much better status bar
let g:airline_theme     = 'zenburn'

function! AirlineInit()
    let g:airline_section_a = airline#section#create(['file', 'readonly'])
    let g:airline_section_b = airline#section#create([''])
    let g:airline_section_c = airline#section#create([''])
    let g:airline_section_x = airline#section#create([''])
    let g:airline_section_y = airline#section#create([''])
    let g:airline_section_z = airline#section#create(['mode'])
endfunction
autocmd! User AirlineAfterInit call AirlineInit()

" Short form mode name 
let g:airline_mode_map = {
            \ '__' : '-',
            \ 'n'  : 'N',
            \ 'i'  : 'I',
            \ 'R'  : 'R',
            \ 'c'  : 'C',
            \ 'v'  : 'V',
            \ 'V'  : 'V',
            \ '' : 'V',
            \ 's'  : 'S',
            \ 'S'  : 'S',
            \ '' : 'S',
            \ }
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_powerline_fonts               = 1
let g:airline_left_sep                      = ''
let g:airline_left_alt_sep                  = ''
let g:airline_right_sep                     = ''
let g:airline_right_alt_sep                 = ''
let g:airline_symbols.branch                = ''
let g:airline_symbols.linenr                = ''
let g:airline_symbols.readonly              = '🔒'
let g:airline_symbols.paste                 = 'ρ'
let g:airline#extensions#tagbar#enabled     = 0
let g:airline#extensions#wordcount#enabled  = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#quickfix#enabled   = 0
let g:airline#extensions#eclim#enabled      = 0
let g:airline#extensions#netrw#enabled      = 0

" My own wiki
nnoremap <Leader>vw :VimwikiIndex<cr>
nnoremap <leader>vd :VimwikiMakeDiaryNote<cr>
let g:vimwiki_hl_headers    = 1
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_auto_chdir    = 1

" Eclim java
nnoremap          <leader>jr :JavaRename<space>
nnoremap          <leader>jc :JavaCorrect<cr>
nnoremap <silent> <leader>jf :w<cr>:%JavaFormat<cr>
nnoremap <silent> <leader>ji :JavaImportOrganize<cr>
nnoremap <silent> <leader>jv :JavaValidate<cr>
nnoremap <silent> <leader>jh :JavaCallHierarchy<cr>
nnoremap <silent> <leader>jp :PingEclim<cr>
nnoremap <silent> <leader>jx :ShutdownEclim<cr>
let g:EclimCompletionMethod = 'omnifunc'

" Fugitive so awesome it is illegal
cabbrev gst Gstatus
cabbrev gdf Gdiff
cabbrev gcm Gcommit
cabbrev glg Glog
cabbrev gpl Gpull
cabbrev gps Gpush
cabbrev grm Gremove
cabbrev gmv Gmove

" EasyAlign
vmap <Enter> <Plug>(EasyAlign)
nmap ga      <Plug>(EasyAlign)

" Use fzf for the win
let g:fzf_layout = { 'down': '~25%' }
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fl :Lines<cr>
nnoremap <leader>fw :Windows<cr>
nnoremap <leader>fb :Buffers<cr>

" Better use of fzf yet
imap <c-x><c-f> <Plug>(fzf-complete-file-ag)
imap <c-x><c-l> <Plug>(fzf-complete-line)
nnoremap <silent><leader>K :call SearchWordWithAg()<CR>
vnoremap <silent><leader>K :call SearchVisualSelectionWithAg()<CR>

function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
endfunction
function! SearchVisualSelectionWithAg() range
    let old_reg       = getreg('"')
    let old_regtype   = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection     = getreg('"')
    call setreg('"',  old_reg, old_regtype)
    let &clipboard    = old_clipboard
    execute 'Ag'      selection
endfunction

" Eat my dust, eclipse
cabbrev todo  Ag TODO
cabbrev fixme Ag FIXME
cabbrev xxx   Ag XXX
cabbrev note  Ag note

" For the mean time, use this instead
inoremap <c-j> <c-n>
inoremap <c-k> <c-p>

" YCM settings
let g:ycm_add_preview_to_completeopt = 0

" Goyo
nnoremap <leader>gg :Goyo<cr>
nnoremap <leader>gx :Goyo!<cr>
let g:goyo_linenr = 0
let g:goyo_width  = 125
let g:goyo_height = 999

" Fuzzy search
map /         <Plug>(incsearch-fuzzy-/)
map ?         <Plug>(incsearch-fuzzy-?)
" Enable exact searching as well
map <leader>/ <Plug>(incsearch-forward)
map <leader>? <Plug>(incsearch-backward)

" Auto remove highlight when cursor is moved
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)zz
map N  <Plug>(incsearch-nohl-N)zz
map *  <Plug>(incsearch-nohl-*)zz
map #  <Plug>(incsearch-nohl-#)zz
map g* <Plug>(incsearch-nohl-g*)zz
map g# <Plug>(incsearch-nohl-g#)zz
let g:incsearch#consistent_n_direction            = 1
let g:incsearch#do_not_save_error_message_history = 1
let g:incsearch#magic                             = '\v' " very magic

" ====================
" VIM-Plugin-Manager
" ====================
call plug#begin('~/.vim/plugged')

nnoremap <leader>pi :PlugInstall<cr>
nnoremap <leader>pu :PlugUpdate<cr>

Plug 'bling/vim-airline'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rsi'
Plug 'junegunn/fzf',            { 'dir' : '~/.fzf', 'do' : './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align', { 'on' : ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'vimwiki/vimwiki'
Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events' " Need this to get vim autoread working properly
Plug 'Valloric/YouCompleteMe'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'

augroup ycm
    autocmd!
    autocmd User YouCompleteMe call youcompleteme#Enable()
augroup END

" Add plugins to &runtimepath
call plug#end()

