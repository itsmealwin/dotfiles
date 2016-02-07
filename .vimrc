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

" ================================================================================
" VIM-Plugin-Manager
" ================================================================================
call plug#begin('~/.vim/plugged')

nnoremap <leader>pi :PlugInstall<cr>
nnoremap <leader>pu :PlugUpdate<cr>

Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rsi'
Plug 'junegunn/fzf',            { 'dir' : '~/.fzf', 'do' : './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim',       { 'on'  : 'Goyo' }
Plug 'junegunn/vim-easy-align', { 'on'  : ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'vimwiki/vimwiki'
Plug 'tmux-plugins/vim-tmux',   { 'for' : 'tmux' }
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'sheerun/vim-polyglot'
Plug 'SirVer/ultisnips'
Plug 'easymotion/vim-easymotion'
Plug 'itchyny/calendar.vim',    { 'on'  : 'Calendar' }
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'terryma/vim-expand-region'
Plug 'vim-scripts/YankRing.vim'
Plug 'wellle/targets.vim'

" Plug 'benekastah/neomake'
" autocmd! BufWritePost * Neomake

Plug 'Valloric/YouCompleteMe'
augroup yicm
    autocmd!
    autocmd User YouCompleteMe call youcompleteme#Enable()
augroup END

" Add plugins to &runtimepath
call plug#end()

" ================================================================================
" PLUGIN settings
" ================================================================================

" My own wiki
cabbrev vw silent VimwikiIndex
nnoremap <Leader>vww <Plug>VimwikiIndex
nnoremap <Leader>vwt <Plug>VimwikiTabIndex
nnoremap <Leader>vwq <Plug>VimwikiUISelect
nnoremap <Leader>vwi <Plug>VimwikiDiaryIndex
nnoremap <Leader>vwdd <Plug>VimwikiMakeDiaryNote
nnoremap <Leader>vwdt <Plug>VimwikiTabMakeDiaryNote
nnoremap <Leader>vwdi <Plug>VimwikiDiaryGenerateLinks

let g:vimwiki_hl_headers    = 1
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_auto_chdir    = 1

" Eclim java
cabbrev jr JavaRename
cabbrev jc JavaCorrect
cabbrev jf %JavaFormat
cabbrev jd JavaDocPreview
cabbrev ji JavaImportOrganize
cabbrev jv JavaValidate
cabbrev jh JavaCallHierarchy
cabbrev jp PingEclim
cabbrev jx ShutdownEclim

let g:EclimCompletionMethod = 'omnifunc'

" EasyAlign
vmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Use fzf for the win
let g:fzf_layout = { 'down' : '35%' }
nnoremap <leader>ff :MyFzfFiles<cr>
nnoremap <leader>fl :Lines<cr>
nnoremap <leader>fw :Windows<cr>
nnoremap <leader>fb :Buffers<cr>
nnoremap <leader>ft :Tags<cr>
nnoremap <leader>fm :Marks<cr>

" Better use of fzf yet
imap     <c-x><c-f>        <Plug>(fzf-complete-file-ag)
imap     <c-x><c-l>        <Plug>(fzf-complete-line)
nnoremap <silent><leader>K :call SearchWordWithAg()<CR>
vnoremap <silent><leader>K :call SearchVisualSelectionWithAg()<CR>

function! SearchWordWithAg()
    execute 'Ag --path-to-agignore=~/.agignore --hidden' expand('<cword>')
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

command! MyFzfFiles call fzf#run({
            \ 'source':  'ag -l --path-to-agignore=~/.agignore --hidden',
            \ 'sink':    'edit',
            \ 'options': '--color=hl:9,fg:8,bg:234,fg+:3 --ansi --cycle',
            \ 'down':    '35%'
            \ })

command! Fd call fzf#run({
            \ 'source':  'find . -not \( -path "*/.svn*" -o -path "*/.git*" -o -path "*/.m2*" -o -path "*/.cache*" -o -path "/tmp*" -o -path "*/target*" -o -path "*/.metadata*" -prune \) -type d',
            \ 'sink':    'cd',
            \ 'options': '--color=hl:9,fg:8,bg:234,fg+:3 --ansi --cycle',
            \ 'down':    '35%'
            \ })

" Eat my dust, eclipse
cabbrev todo  Ag TODO
cabbrev fixme Ag FIXME
cabbrev xxx   Ag XXX
cabbrev note  Ag note

" YCM settings
let g:ycm_add_preview_to_completeopt          = 0
let g:ycm_min_num_of_chars_for_completion     = 2
let g:ycm_min_num_identifier_candidate_chars  = 4
let g:ycm_key_list_select_completion          = ['<TAB>', '<Down>']
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax        = 1

" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction
inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

" Ultisnips
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

" Goyo
nnoremap <leader>gg :Goyo<cr>
nnoremap <leader>gx :Goyo!<cr>
let g:goyo_linenr = 0
let g:goyo_width  = 150
let g:goyo_height = 300

" Rainbow parentheses activation based on file type
augroup rainbow_lisp
  autocmd!
  autocmd FileType java,vim,tmux,php,bash,python RainbowParentheses
  autocmd BufNewFile,BufRead *.tex set filetype=tex
  autocmd BufNewFile,BufRead *.fish set filetype=sh
  autocmd BufNewFile,BufRead *.click set filetype=asm
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" New fuzzy word search
map <leader>/  <Plug>(incsearch-fuzzyword-/)
map <leader>?  <Plug>(incsearch-fuzzyword-?)
map <leader>g/ <Plug>(incsearch-fuzzyword-stay)
map /          <Plug>(incsearch-forward)
map ?          <Plug>(incsearch-backward)
map g/         <Plug>(incsearch-stay)

let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)zz
map N  <Plug>(incsearch-nohl-N)zz
map *  <Plug>(incsearch-nohl-*)zz
map #  <Plug>(incsearch-nohl-#)zz
map g* <Plug>(incsearch-nohl-g*)zz
map g# <Plug>(incsearch-nohl-g#)zz

" Easy motion settings
let g:EasyMotion_prompt = '{n}>>> '
" Let me define my own mappings
let g:EasyMotion_do_mapping = 0
" I don't lilke symbols on the target keys
let g:EasyMotion_keys = 'ASDGHKLQWERTYUIOPZXCVBNMFJ'
" Enter space to jump directly to first match
let g:EasyMotion_space_jump_first = 1
" Don't litter my screen please
let g:EasyMotion_verbose = 0
" Use Upper case for better readability
let g:EasyMotion_use_upper = 1

" nmap f <Plug>(easymotion-bd-fl)
" xmap f <Plug>(easymotion-bd-fl)
" omap f <Plug>(easymotion-bd-fl)

" nmap F <Plug>(easymotion-bd-f)
" xmap F <Plug>(easymotion-bd-f)
" omap F <Plug>(easymotion-bd-f)

" nmap t <Plug>(easymotion-bd-tl)
" xmap t <Plug>(easymotion-bd-tl)
" omap t <Plug>(easymotion-bd-tl)

" nmap T <Plug>(easymotion-bd-t)
" xmap T <Plug>(easymotion-bd-t)
" omap T <Plug>(easymotion-bd-t

" nmap ; <Plug>(easymotion-next)
" xmap ; <Plug>(easymotion-next)
" omap ; <Plug>(easymotion-next)

" nmap , <Plug>(easymotion-prev)
" xmap , <Plug>(easymotion-prev)
" omap , <Plug>(easymotion-prev)

nmap <Leader>s <Plug>(easymotion-sn)
xmap <Leader>s <Plug>(easymotion-sn)
omap <Leader>z <Plug>(easymotion-sn)

nmap <leader>l <Plug>(easymotion-lineanywhere)
xmap <leader>l <Plug>(easymotion-lineanywhere)
omap <leader>l <Plug>(easymotion-lineanywhere)

nmap <leader>j <Plug>(easymotion-bd-jk)
xmap J <Plug>(easymotion-bd-jk)
omap J <Plug>(easymotion-bd-jk)

nmap <leader>W <Plug>(easymotion-bd-W)
xmap <leader>W <Plug>(easymotion-bd-W)
omap <leader>W <Plug>(easymotion-bd-W)

nmap <leader>w <Plug>(easymotion-bd-w)
xmap <leader>w <Plug>(easymotion-bd-w)
omap <leader>w <Plug>(easymotion-bd-w)

nmap s <Plug>(easymotion-bd-f)
xmap z <Plug>(easymotion-bd-f)
omap z <Plug>(easymotion-bd-f)

nmap S <Plug>(easymotion-bd-t)
xmap Z <Plug>(easymotion-bd-t)
omap Z <Plug>(easymotion-bd-t)

" Calendar
cabbrev ccal Calendar -view=year -split=vertical -width=27
cabbrev ctime Calendar -view=clock

" Yankring
let g:yankring_min_element_length = 3

" ================================================================================
                                 " VIM SETTINGS
" ================================================================================

" Can NOT live without this
syntax on
" Don't highlight past certain length; slows down vim on long lines
set synmaxcol=150

" Help me indent
set autoindent
" Better background for vim
set background=dark

" Best colorscheme for my eyes
colorscheme gruvbox
" Even better gruvbox
let g:gruvbox_contrast_dark = 'hard'
" Solarized settings so that it actually works
let g:solarized_termcolors  = 256

" My own status line
set statusline=%#GruvboxPurple#%<\ %=%#GruvboxRedBold#%m\ %#Type#%t\ %r%w\ \ %#Type#%l\/%-6L
" hi statusLine ctermbg=208 ctermfg=red

" Apparently there is a security issue with modelines
set modelines=0
" Don't clutter my screen with all completion options
set pumheight=5
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
set timeoutlen=3000
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
set formatoptions+=j
" Don't continue comment mark after press 'o' when youre on a commented line
set formatoptions-=o

" More intelligent tag finding
set tags=./tags,tags;

" Disable mouse
set mouse=
" Don't use octal, vim
set nrformats="alpha"

" Quicker text objects
omap iq i"
omap aq a"
omap iQ i'
omap aQ a'
omap ic i[
omap ac a[

" Always start visual LINE mode
nnoremap v <c-v>
vnoremap v <c-v>

" Enable intuitive moving on wrapped lines
nmap j gj
nmap k gk

" Move to beginning/end of line
nnoremap <m-h> ^
vnoremap <m-h> ^
nnoremap <m-l> $
vnoremap <m-l> $

" Q to replay the marco.
nnoremap Q @q
vnoremap Q @q

" Enable true color
set t_Co=256
" Set tab to 4 whitespaces
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set smarttab
set shiftround

" Show line number but also relative line number
" set ruler
" set relativenumber
set number
set numberwidth=10

" Ignore case when searching
set ignorecase
set smartcase
" Ignore case on insert completion
set infercase

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Always use vertical diffs
set diffopt+=vertical

" Auto resize Vim splits to active split
set winwidth=100
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

" Skip scanning the usr/include files, they are large, ctags are faster anyway
set complete-=i
" Highlight search
set hlsearch
set incsearch

" Set hidden buffers
set nohidden

" Delete all trailing whitespaces and multiple blank lines
function! <SID>StripTrailingWhitespacesAndMultipleBlankLines()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    %s/\n\{3,}/\r\r/e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
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
    autocmd BufWrite * :silent call <SID>StripTrailingWhitespacesAndMultipleBlankLines()
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
" inoremap . .<c-g>u
" inoremap ! !<c-g>u
" inoremap ? ?<c-g>u
" inoremap : :<c-g>u
" inoremap ; ;<c-g>u
" inoremap ( (<c-g>u
" inoremap { {<c-g>u
" inoremap [ [<c-g>u

" Make some jumps more intuitive and don't require the '{' to be in the first column
nnoremap <silent> [[ ?{<CR>w99[{:nohl<CR>
nnoremap <silent> ][ j0?{<CR>w99[{%/{<CR>:nohl<CR>
nnoremap <silent> ]] ][
xnoremap <silent> [[ ?{<CR>w99[{:<C-U>nohl<CR>gv
xnoremap <silent> ][ j0?{<CR>w99[{%/{<CR>:<C-U>nohl<CR>gv
xnoremap <silent> ]] ][

" Set to auto-read when a file is changed from the outside
set autoread
set autowrite

" Use custom ignore to exlude directories and certain files
set wildignore+=*/tmp/*,*.so,*.swp,.DS_Store
set wildignore+=*.zip,*.rar,*.tar.gz,*.tar.bz2
set wildignore+=*.jar,*.class,*/target/**/*,*.xmi
set wildignore+=*.network,*.pdict,*exe
set wildignore+=*/.svn/**/*,*/.git/**/*,*/.hg/**/*
set wildignore+=*.iso,*.bin
set wildignore+=*.gif,*.jpg,*.bmp,*.png,*.jpeg,*.mp4,*.avi,*.mp3
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
set fileformats=unix,dos,mac
set listchars=tab:»·,trail:·
set nolist
set title
" Shorter message
set shortmess=atT
" Better tab even
runtime macros/matchit.vim

" Keep cursor in the middle of the screen if possible
set scrolloff=0
" Also don't scroll until the end of the screen if possible
set sidescrolloff=15
set sidescroll=1

" Backups
set backupdir=~/.backup-vim
set directory=~/.backup-vim
set noswapfile

" Make ESC works faster
set ttimeout
set ttimeoutlen=0
" Menu completion on command via <tab>
set wildmenu
" First list the available options and complete the longest common part, then have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full
" Please ignore case when giving me suggestion
set wildignorecase

" --------------------------------------------------------------------------------
                           " Some personal utilities
" --------------------------------------------------------------------------------

" Create a banner
nnoremap <leader>= :center<cr>mzo<esc>80i=<esc>:Commentary<cr>kO<esc>80i=<esc>:Commentary<cr>`z:Commentary<cr>`z
nnoremap <leader>- :center<cr>mzo<esc>80i-<esc>:Commentary<cr>kO<esc>80i-<esc>:Commentary<cr>`z:Commentary<cr>`z
nnoremap <leader>d mz:Commentary<cr>k"_dd`zj"_dd`z

" Move to beginning/end of paragraph
nnoremap g{        :<C-u>exe "norm k".v:count1."{j"<CR>``j``zz
nnoremap g}        :<C-u>exe "norm j".v:count1."}k"<CR>``k``zz

" Split window in vertical splits, and continuously show the file (1-10, 10-20, ...)
" noremap <silent><leader>sb :<c-u>let @z=&so<cr>:set so=0 noscb<cr>:bo vs<cr>Ljzt:setl scb<cr><c-w>p:setl scb<cr>:let &so=@z<cr>

" Generate tags
nnoremap <silent><f1> :silent !tmux new -d ct 2>/dev/null 1>&2 &<cr>:echo "CTags Generated!"<cr><cr>
" Quickly hide everything
nnoremap <silent><f5> mzggg?G`zzz
" I love/hate this
set cpoptions-=$

" Center the screen around everything
nnoremap G     Gzz
nnoremap u     uzz
nnoremap <c-r> <c-r>zz
nnoremap <c-d> <c-d>zz
nnoremap <c-u> <c-u>zz
nnoremap <c-f> <c-f>zz
nnoremap <c-b> <c-b>zz
nnoremap <c-t> <c-t>zz
nnoremap <c-]> <c-]>zz
nnoremap <c-o> <c-o>zz
nnoremap <c-i> <c-i>zz

"Make Y yank to end of line (like D, or C)
nmap Y y$

" Copy to clipboard, http://news.ycombinator.com/item?id=4767227 , use 3 \y to copy 3 lines
nnoremap <leader>y @='mzggVG"*y`z'<cr>
" Paste from clipboard
nnoremap <c-p> mz"*p`z
nnoremap <c-p> mz"*P`z

" Reselect pasted text. Mnem: 'Get pasted'
nnoremap vp `[v`]

" Resize panes
nnoremap <silent><Right> :vertical resize +5<cr>
nnoremap <silent><Left>  :vertical resize -5<cr>
nnoremap <silent><Up>    :resize +5<cr>
" Use tab to jump between blocks, because it's easier
nnoremap <tab> %
" Go to the end of pasted text, easier to spam paste
nnoremap p p`]
" Put text from default register under/over current line
nnoremap <silent> <leader>pj mz:pu<cr>`[=`]`z
nnoremap <silent> <leader>pk mz:pu!<cr>`[=`]`z
" Duplicate the selection
vnoremap D y`]pgv

" Make regex more sane
nnoremap :s/ :s/\v

" Also center for quickfix-list
nnoremap ]c ]czz
nnoremap [c [czz
" Basically center everything
nnoremap g; g;zz
nnoremap g, g,zz

" Split line
nnoremap K i<cr><esc>
" Reselect visual block after indenting
vnoremap < <gv
vnoremap > >gv
" * and # without moving the cursor
nnoremap <Leader>* *<c-o>
nnoremap <Leader># #<c-o>

" Faster command mode
nnoremap <cr>     :
vnoremap <cr>     :
" Create newlines without entering insert mode
nnoremap go       o<Esc>k
nnoremap gO       O<Esc>j
nnoremap g<space> mzo<esc>kO<esc>j`z

" Slightly faster movement
nnoremap <c-e>         6<c-e>
vnoremap <c-e>         6<c-e>
nnoremap <c-y>         6<c-y>
vnoremap <c-y>         6<c-y>
nnoremap <silent><f9>  3{zz
vnoremap <silent><f9>  3{zz
nnoremap <silent><f10> 3}zz
vnoremap <silent><f10> 3}zz
nnoremap <m-w>         W
nnoremap <m-e>         E
nnoremap <m-b>         B
" Delete backward a word in insert mode
inoremap <m-w>         <c-w>

" Fast saving
nnoremap <leader><leader>   :w<cr>:nohlsearch<Bar>:echo<CR>
inoremap <c-s>              <esc>:w<cr>:nohlsearch<Bar>:echo<CR>
" Quickly close windows
nnoremap <leader>x          :x<cr>
nnoremap <leader>q          :q<cr>
nnoremap <m-q>              :q!<cr>
" Quickly close buffer
nnoremap <silent><leader>bb :bd<cr>
" Move current line up and down
nnoremap <m-j>              :m+<CR>
nnoremap <m-k>              :m-2<CR>
inoremap <m-j>              <Esc>:m+<CR>
inoremap <m-k>              <Esc>:m-2<CR>
vnoremap <m-j>              :m'>+<CR>gv
vnoremap <m-k>              :m-2<CR>gv
" Open new buffer in current window
nnoremap <leader>ee         :ene<cr>:set ft=tex<cr>
" Quickly move between panes
vnoremap <c-h> <c-w>hzz
vnoremap <c-j> <c-w>jzz
vnoremap <c-k> <c-w>kzz
vnoremap <c-l> <c-w>lzz
nnoremap <c-h> <c-w>hzz
nnoremap <c-j> <c-w>jzz
nnoremap <c-k> <c-w>kzz
nnoremap <c-l> <c-w>lzz

" Quick cd and config edits
cabbrev  acs     cd ~/Documents/WorkspaceDaiAcs/acs/trunk
cabbrev  distal  cd ~/Documents/Uni/Masterstudium/DistributedAlgorithms/WorkspaceDistributedAlgorithm
cabbrev  wlab    cd ~/Documents/Uni/Masterstudium/WirelessLab/WorkspaceWirelessLab
cabbrev  te      tab split
cabbrev  tt      tabnew
cabbrev  vv      tabedit $MYVIMRC
cabbrev  vimrc   tabedit $MYVIMRC
cabbrev  gvimrc  tabedit ~/.gvimrc
cabbrev  cfish   tabedit ~/.config/fish/config.fish
cabbrev  tconf   tabedit ~/.tmux.conf
cabbrev  cclipse tabedit ~/../../Applications/Eclipse/Eclipse.app/Contents/Eclipse/configuration/config.ini"

" ================================================================================
                                " Abbreviations
" ================================================================================

" My contacts
iabbrev _me   Alwin
iabbrev _mail itsmealwinalwin@gmail.com

" Correcting those typos
iabbrev alos      also
iabbrev aslo      also
iabbrev charcter  character
iabbrev charcters characters
iabbrev exmaple   example
iabbrev shoudl    should
iabbrev seperate  separate
iabbrev teh       the

" Format XML:
cabbrev fxml %!xmllint --format -

" Format CSV:
cabbrev fcsv %!column -s, -t

" Format JSON:
cabbrev fjson %!python -m json.tool

" ================================================================================
" Completely disable mouse scrolling
" ================================================================================

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

" ================================================================================"
" TMUX specific settings
" ================================================================================"

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

" ================================================================================
" Use AG (the silver searcher) instead of grep
" ================================================================================

" :grep foo *.js
set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column\ --vimgrep
set grepformat=%f:%l:%c:%m
" :Grep foo :LGrep bar
command! -nargs=+ -complete=file_in_path -bar Grep  silent! grep! <args> | redraw!
command! -nargs=+ -complete=file_in_path -bar LGrep silent! lgrep! <args> | redraw!

" ================================================================================
" Help in new tabs
" ================================================================================

function! s:helptab()
    if &buftype == 'help'
        wincmd T
        nnoremap <buffer> q    :q<cr>
        nnoremap <buffer> <cr> <c-]>zz
        nnoremap <buffer> <bs> <c-t>zz
    endif
endfunction

augroup vimrc_help
    autocmd!
    autocmd BufEnter *.txt call s:helptab()
augroup END

" ================================================================================
" Java specific settings
" ================================================================================

let java_highlight_all=1
let java_highlight_java_lang_ids=1
let java_highlight_functions="style"
let java_highlight_debug=1

augroup MyJavaSettings
    autocmd!
    autocmd FileType java set path=**
    autocmd FileType java nnoremap ]] ]mzz
    autocmd FileType java nnoremap [[ [mzz
augroup END

" ================================================================================
" Python specific settings
" ================================================================================

" Enable all Python syntax highlighting features
let python_highlight_all = 1

" ================================================================================
" NEOVIM specific settings
" ================================================================================

if has('nvim')

    " Faster startup time on neovim
    let g:python_host_skip_check = 1
    let g:python3_host_skip_check = 1

    " Fix the pane switching
    nnoremap <BS> <c-w>hzz
    vnoremap <BS> <c-w>hzz

    " Self explanatory
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

endif

" ================================================================================
" Delete all buffer except the current one
" ================================================================================

" BufOnly.vim  -  Delete all the buffers except the current/named buffer.
"
" Copyright November 2003 by Christian J. Robinson <infynity@onewest.net>
" Distributed under the terms of the Vim license.  See ":help license".
"
" Usage:
" :Bonly / :BOnly / :Bufonly / :BufOnly [buffer]
"
" Without any arguments the current buffer is kept.  With an argument the
" buffer name/number supplied is kept.

cabbrev bo BufOnly

command! -nargs=? -complete=buffer -bang Bonly
    \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang BOnly
    \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang Bufonly
    \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang BufOnly
    \ :call BufOnly('<args>', '<bang>')

function! BufOnly(buffer, bang)
	if a:buffer == ''
		" No buffer provided, use the current buffer.
		let buffer = bufnr('%')
	elseif (a:buffer + 0) > 0
		" A buffer number was provided.
		let buffer = bufnr(a:buffer + 0)
	else
		" A buffer name was provided.
		let buffer = bufnr(a:buffer)
	endif

	if buffer == -1
		echohl ErrorMsg
		echomsg "No matching buffer for" a:buffer
		echohl None
		return
	endif

	let last_buffer = bufnr('$')

	let delete_count = 0
	let n = 1
	while n <= last_buffer
		if n != buffer && buflisted(n)
			if a:bang == '' && getbufvar(n, '&modified')
				echohl ErrorMsg
				echomsg 'No write since last change for buffer'
							\ n '(add ! to override)'
				echohl None
			else
				silent exe 'bdel' . a:bang . ' ' . n
				if ! buflisted(n)
					let delete_count = delete_count+1
				endif
			endif
		endif
		let n = n+1
	endwhile

	if delete_count == 1
		echomsg delete_count "buffer deleted"
	elseif delete_count > 1
		echomsg delete_count "buffers deleted"
	endif

endfunction
