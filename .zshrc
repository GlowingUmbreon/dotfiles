alias music="~/.dotfiles/scripts/play_music.sh"
alias status="~/.dotfiles/scripts/status.sh"

export _JAVA_AWT_WM_NONREPARENTING=1 export AWT_TOOLKIT=MToolkit # fix java for Void linux

# The following lines were added by compinstall
zstyle :compinstall filename '/home/umbreon/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
