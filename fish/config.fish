#       ad88  88             88
#      d8"    ""             88
#      88                    88
#    MM88MMM  88  ,adPPYba,  88,dPPYba,
#      88     88  I8[    ""  88P'    "8a
#      88     88   `"Y8ba,   88       88
#      88     88  aa    ]8I  88       88
#      88     88  `"YbbdP"'  88       88

# ================================================================================
# Common settings
# ================================================================================

# Path to Oh My Fish install.
set -gx OMF_PATH /Users/alwin/.local/share/omf
set -x  LC_ALL   en_US.UTF-8
set -x  LANG     en_US.UTF-8

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG /Users/alwin/.config/omf

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

# Environments
set -x PATH /usr/local/sbin /usr/local/opt/coreutils/libexec/gnubin ~/.bin $PATH
set -x MANPATH /usr/local/opt/coreutils/libexec/gnuman /usr/local/man $MANPATH
set -x EDITOR nvim
set -x SVNEDITOR nvim
set -x fish_term24bit 1

# Get some colors
set -x LESS_TERMCAP_mb (printf "\033[01;31m")
set -x LESS_TERMCAP_md (printf "\033[01;31m")
set -x LESS_TERMCAP_me (printf "\033[0m")
set -x LESS_TERMCAP_se (printf "\033[0m")
set -x LESS_TERMCAP_so (printf "\033[01;44;33m")
set -x LESS_TERMCAP_ue (printf "\033[0m")
set -x LESS_TERMCAP_us (printf "\033[01;32m")

# TLDR color-fix
set -x TLDR_COLOR_BLANK "white"
set -x TLDR_COLOR_NAME "cyan"
set -x TLDR_COLOR_DESCRIPTION "white"
set -x TLDR_COLOR_EXAMPLE "green"
set -x TLDR_COLOR_COMMAND "white"

# FZF settings
set -x FZF_TMUX 0
set -x FZF_DEFAULT_COMMAND "ag -l --path-to-agignore=~/.agignore --hidden"

# Remote neovim-settings
set -x NVIM_LISTEN_ADDRESS "/tmp/nvimsocket nvim"

# ================================================================================
                                   # Utilities
# ================================================================================

function r
    command pygmentize $argv
end

# Eject some unejectable discs..
function eject
    command drutil tray eject
end

# Empty the trash, linux way
function emptyTrash
    command sudo rm -rf ~/.Trash/*
end

# Tick tock tick tock
function clock
    command tty-clock -C 6
end

# Pretty please
function pls
    command sudo $argv
end

# Unzip zip files
function uzp
    command unzip $argv
end

# Open a file with default app
function o
    command open $argv
end

# Searching for text in PDF files
function pgrep
    command pdfgrep -n
end

# Never use other maven commands anymore
function mpk
    set_color brown
    command mvn package
    set_color normal
end

# Find out current IPs
function ips
    command ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ and print $1'
end

# ================================================================================
                                 # GIT functions
# ================================================================================

function g
    command git $argv
end

# ================================================================================
                           # Quickly edit config files
# ================================================================================

function vimrc
    command vim ~/.vim/init.vim
end

function mvimrc
    command mvim ~/.vim/init.vim
end

function nvimrc
    command nvim ~/.vim/init.vim
end

function v
    command nvim $argv
end

function nv
    command nvim -u NONE $argv
end

function m
    command mvim --remote-silent $argv
end

function vrapperrc
    command nvim ~/.vrapperrc
end

function cfish
    command nvim ~/.config/fish/config.fish
end

function cclipse
    command nvim ~/../../Applications/Eclipse/Eclipse.app/Contents/Eclipse/configuration/config.ini
end

# ================================================================================
                                  # Tmux related
# ================================================================================

function tconf
    command nvim ~/.tmux.conf
end

function tvs
    command tmux splitw -h -p $argv
end

function tss
    command tmux splitw -v -p $argv
end

function ta
    command tmux attach
end

function tat
    command tmux attach -t $argv
end

function tls
    set_color green
    command tmux ls
    set_color normal
end

function tns
    command tmux new-session -s $argv
end

# ================================================================================
                                  # CD functions
# ================================================================================

# Faster moving around
function l
    command ls -AhlGF $argv
end

function ls
    command ls -AGF $argv
end

function ..
    cd ..
    command ls -AhlGF
end

function ...
    cd ../..
    command ls -AhlGF
end

function ....
    cd ../../..
    command ls -AhlGF
end

function up
    cd ..
    command ls -AhlGF
end

function up2
    cd ../..
    command ls -AhlGF
end

function up3
    cd ../../..
    command ls -AhlGF
end

function up4
    cd ../../../..
    command ls -AhlGF
end

function c
    cd $argv
    command ls -AhlGF
end

function dwl
    cd ~/Downloads
    command ls -AhlGF
end

function dcm
    cd ~/Documents
    command ls -AhlGF
end

function acs
    cd ~/Documents/WorkspaceDaiAcs/acs/trunk
    command ls -AhlGF
end

function pgui
    cd ~/Documents/WorkspaceDaiAcs/.metadata/.plugins/org.eclipse.pde.core/auvegos.product
    command ls -AhlGF
end

function pbackend
    cd ~/Documents/WorkspaceDaiAcs/.metadata/.plugins/org.eclipse.pde.core/auvegos-backend.product
    command ls -AhlGF
end

function gui
    cd ~/Documents/WorkspaceDaiAcs/acs/trunk/acs.releases/auvegos.product.ui/target/products/auvegos.gui.product/macosx/cocoa/x86_64
    command ls -AhlGF
end

function backend
    cd ~/Documents/WorkspaceDaiAcs/acs/trunk/acs.releases/auvegos.product.backend/target/products/auvegos.backend.product/macosx/cocoa/x86_64
    command ls -AhlGF
end

function wlab
    cd ~/Documents/Uni/Masterstudium/WirelessLab/WorkspaceWirelessLab
    command ls -AhlGF
end

function distal
    cd ~/Documents/Uni/Masterstudium/DistributedAlgorithms/WorkspaceDistributedAlgorithm
    command ls -AhlGF
end

function wiki
    cd ~/vimwiki
    command ls -AhlGF
end

function -
    cd -
    command ls -AhlGF
end

# ================================================================================
                               # Personal functions
# ================================================================================

# Autojump to the most commonly used directories
[ -f /usr/local/share/autojump/autojump.fish ]; and . /usr/local/share/autojump/autojump.fish

# Recursively delete .DSStore
function deldstore
    command find . -name '*.DS_Store' -type f -ls -delete
end

# Enable Spotlight
function spoton
    command sudo mdutil -a -i on
end

# Disable Spotlight
function spotoff
    command sudo mdutil -a -i off
end

# Pretty print the path
function path
    command echo $PATH | tr -s ":" "\n"
end

# Show process sorted by CPU usage
function cpu
    command top -o cpu
end

# Show process sorted by memory usage
function mem
    command top -o rsize
end

# Faster ping 20 packets, every 0.1 secs
function gping
    set_color 62A
    command ping -c 20 -i 0.1 google.de
    set_color normal
end

function sourceMyFishConfig
    set_color 65A
    source ~/.config/fish/config.fish
    set_color normal
end

# ================================================================================
                                # Eclim functions
# ================================================================================

# Start eclim daemon
function ecd
    set_color blue
    command /Applications/Eclipse/Eclipse.app/Contents/Eclipse/eclimd
    set_color normal
end

# ================================================================================
                                 # FZF functions
# ================================================================================

# kill a process found by fzf
function fk
    command ps aux | sed 1d | fzf --color=hl:9,fg:8,bg:233,fg+:3 --ansi --cycle | awk '{print $2}' > $TMPDIR/fzf.result; and kill (cat $TMPDIR/fzf.result) > /dev/null ^ /dev/null
end

# cd to the directory of the file
function f
command find . -not \( -path "*/.svn*" -o -path "*/.git*" -o -path "*/.m2*" -o -path "*/.cache*" -o -path "/tmp*" -o -path "*/target*" -o -path "*/.metadata*" -prune \) -type d | fzf --color=hl:9,fg:8,bg:233,fg+:3 --ansi --cycle > $TMPDIR/fzf.result; and cd (cat $TMPDIR/fzf.result)
    command ls -AhlGF
end

# cd to the directory of the file, starting from $HOME
function ff
command find ~ -not \( -path "/Users/alwin" -o -path "*/.svn*" -o -path "*/.git*" -o -path "*/.m2*" -o -path "*/.cache*" -o -path "/tmp*" -o -path "*/target*" -o -path "*/.metadata*" -prune \) -type d | fzf --color=hl:9,fg:8,bg:233,fg+:3 --ansi --cycle > $TMPDIR/fzf.result; and cd (cat $TMPDIR/fzf.result)
    command ls -AhlGF
end

# vim a file that is found using fuzzy finder fzf
function fv
    command ag -l --path-to-agignore=~/.agignore --hidden | fzf --color=hl:9,fg:8,bg:233,fg+:3 --ansi --cycle > $TMPDIR/fzf.result; and nvim (cat $TMPDIR/fzf.result);
end

# vim a file found with fzf + ag - respects .agignore and .gitignore
function vgf
    command ag -l --nobreak --nonumbers --noheading --path-to-agignore=~/.agignore --hidden | fzf --color=hl:9,fg:8,bg:233,fg+:3 --ansi --cycle > $TMPDIR/fzf.result; and vim (cat $TMPDIR/fzf.result);
end

# Find a file and open it
function fo
    command ag -l --path-to-agignore=~/.agignore --hidden | fzf --color=hl:9,fg:8,bg:233,fg+:3 --ansi --cycle > $TMPDIR/fzf.result; and open (cat $TMPDIR/fzf.result);
end

# mvim a file that is found using fzf
# function mvf
#     command fzf --ansi --cycle > $TMPDIR/fzf.result; and mvim (cat $TMPDIR/fzf.result);
# end

# ================================================================================
                                 # Ctags function
# ================================================================================

# Generate ctags to only java file (with the help of AG)
function ct
    set_color 30A
    command rm tags
    command echo "deleted old tags"
    command echo "generating new tags..."
    command ag -l --java | ctags -L -
    command echo "tags generated."
    set_color normal
end

# ================================================================================
                            # Directory/File functions
# ================================================================================

# Make directory and all of parent directories
function md
    command mkdir -p $argv
    command ls -AhlGF
end

# Quicker delete the directory
function rmf
    command rm -rf $argv
    command ls -AhlGF
end

function rm
    command rm $argv
    command ls -AhlGF
end

# Show/hide hidden files in Finder
function hide
    command defaults write com.apple.Finder AppleShowAllFiles -bool false
    killall Finder
end
function show
    command defaults write com.apple.Finder AppleShowAllFiles -bool true
    killall Finder
end

# display ls in tree form (level 2)
function tt
    command tree -ahDCL 2 $argv
end

# better grep
function grep
   command grep --color=auto $argv
end

# Portable vim. See: https://github.com/junegunn/myvim
function portVim
    command echo "porting vim..."
    command bash < (curl -fL https://raw.githubusercontent.com/junegunn/myvim/master/myvim)
    command echo "done porting"
end

# Zathura, vim-master-race PDF viewer
function z
    command zathura $argv 2>/dev/null 1>&2 &
    set -l PID (jobs -lp)
    command osascript ~/.local/share/focus.scpt $PID
end

# ================================================================================
                                 # Brew functions
# ================================================================================

function b
    command brew $argv
end

function bd
    set_color 25A
    command brew doctor
    set_color normal
end

# brew routine
function bup
   set_color red
   command   brew update
   set_color green
   command   brew upgrade --all
   set_color purple
   command   brew cleanup
   set_color normal
end

# ================================================================================
                                 # SVN functions
# ================================================================================

function s
    command svn $argv
end

function sci
    command svn commit
end

function sdif
    command svn diff | nvim -d -f - $argv
end

function slog
    set_color blue
    command   svn log -l 5 -v
    set_color normal
end

# ================================================================================
                                 # Fish functions
# ================================================================================

# remove fish greeting
function fish_greeting
end
