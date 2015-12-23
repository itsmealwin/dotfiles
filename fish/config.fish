# Path to Oh My Fish install.
set -gx OMF_PATH /Users/alwin/.local/share/omf
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG /Users/alwin/.config/omf

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

# Environments
set -x PATH /usr/local/sbin $PATH
set -x EDITOR vim

# Get some colors
set -x LESS_TERMCAP_mb (printf "\033[01;31m")
set -x LESS_TERMCAP_md (printf "\033[01;31m")
set -x LESS_TERMCAP_me (printf "\033[0m")
set -x LESS_TERMCAP_se (printf "\033[0m")
set -x LESS_TERMCAP_so (printf "\033[01;44;33m")
set -x LESS_TERMCAP_ue (printf "\033[0m")
set -x LESS_TERMCAP_us (printf "\033[01;32m")

# Aliases
alias l="ls -AhlGF"
alias ls="ls -G"
alias ll="ls -AhlGF"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias eject="drutil tray eject"
alias emptyTrash="sudo rm -rf ~/.Trash/*"
alias hack="cat /dev/urandom | hexdump -C | grep --color=auto(or your choice) \"ca fe\""
alias clock="tty-clock -C 6"
alias c="cd"
alias g="git"
alias pls="sudo"
alias uzp="unzip"
alias o="open"
alias mkdir="mkdir -p"
alias vimrc="vim ~/.vimrc"
alias mvimrc="mvim ~/.vimrc"
alias vrapperrc="vim ~/.vrapperrc"
alias cfish="vim ~/.config/fish/config.fish"
alias cclipse="vim ~/../../Applications/Eclipse/Eclipse.app/Contents/Eclipse/configuration/config.ini"
alias rmf="rm -rf"

# Tmux related
alias tconf="vim ~/.tmux.conf"
alias ta="tmux attach"
alias tat="tmux attach -t"
alias tls="tmux ls"
alias tns="tmux new-session -s"

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# CD-s
alias dwl="cd ~/Downloads"
alias dcm="cd ~/Documents"
alias vhm="cd ~/.vim"
alias acs="cd ~/Documents/WorkspaceDaiAcs/acs/trunk"
alias gui="cd ~/Documents/WorkspaceDaiAcs/acs/trunk/acs.releases/auvegos.product.ui/target/products/auvegos.gui.product/macosx/cocoa/x86_64"
alias backend="cd ~/Documents/WorkspaceDaiAcs/acs/trunk/acs.releases/auvegos.product.backend/target/products/auvegos.backend.product/macosx/cocoa/x86_64"

alias wlab="cd ~/Documents/Uni/Masterstudium/WirelessLab/WorkspaceWirelessLab"
alias distal="cd ~/Documents/Uni/Masterstudium/DistributedAlgorithms/WorkspaceDistributedAlgorithm"

# Recursively delete `.DS_Store` files
alias deldsstore="find . -name '*.DS_Store' -type f -ls -delete"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.Finder AppleShowAllFiles -bool true and killall Finder"
alias hide="defaults write com.apple.Finder AppleShowAllFiles -bool false and killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false and killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true and killall Finder"

# Disable Spotlight
alias spotoff="sudo mdutil -a -i off"
# Enable Spotlight
alias spoton="sudo mdutil -a -i on"

# Function

# Pretty git log
function glog
	command git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(blue)<%an>%Creset' --abbrev-commit | head -15
end

# Start eclim daemon
function ecd
    set_color red
    /Applications/Eclipse/Eclipse.app/Contents/Eclipse/eclimd
    set_color normal
end

# kill a process found by fzf
function kpf
    command ps aux | sed 1d | fzf --ansi --cycle | awk '{print $2}' > $TMPDIR/fzf.result; and kill (cat $TMPDIR/fzf.result) > /dev/null ^ /dev/null
end

# cd to the directory of the file
function cf
    command fzf --ansi --cycle > $TMPDIR/fzf.result; and cd (dirname (cat $TMPDIR/fzf.result))
end

# vim a file that is found using fuzzy finder fzf
function vf
    command fzf --ansi --cycle > $TMPDIR/fzf.result; and vim (cat $TMPDIR/fzf.result);
end

# vim a file found with fzf + ag - respects .agignore and .gitignore
function vgf
    command ag --nobreak --nonumbers --noheading . | fzf --ansi --cycle > $TMPDIR/fzf.result; and vim (cat $TMPDIR/fzf.result);
end

# Find a file and open it
function of
    command fzf --ansi --cycle > $TMPDIR/fzf.result; and open (cat $TMPDIR/fzf.result);
end

# mvim a file that is found using fzf
# function mvf
#     command fzf --ansi --cycle > $TMPDIR/fzf.result; and mvim (cat $TMPDIR/fzf.result);
# end

# display ls in tree form (level 2)
function lll
    command tree -ahDCL 2 $argv
end

# better grep
function grep
   command grep --color=auto $argv
end

# brew routine
function brewup
   set_color red
   command brew update
   set_color green
   command brew upgrade --all
   set_color purple
   command brew cleanup
   set_color normal
end

# svn update
function sup
    set_color green
    command svn up
    set_color normal
end

# svn status
function sst
    set_color yellow
    command svn st -u
    set_color normal
end

# svn log
function slog
    set_color green
    command svn log -l 15 -v
    set_color normal
end

# remove fish greeting
function fish_greeting
    # set_color green
    # fortune -a | cowsay -ny
    # set_color normal
end
