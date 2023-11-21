# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

# Path to powerlevel10k theme
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# List of plugins used
plugins=()
source $ZSH/oh-my-zsh.sh

# In case a command is not found, try to find the package that has it
function command_not_found_handler {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf 'zsh: command not found: %s\n' "$1"
    local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
    if (( ${#entries[@]} )) ; then
        printf "${bright}$1${reset} may be found in the following packages:\n"
        local pkg
        for entry in "${entries[@]}" ; do
            local fields=( ${(0)entry} )
            if [[ "$pkg" != "${fields[2]}" ]] ; then
                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
            fi
            printf '    /%s\n' "${fields[4]}"
            pkg="${fields[2]}"
        done
    fi
    return 127
}

# Detect the AUR wrapper
if pacman -Qi yay &>/dev/null ; then
   aurhelper="yay"
elif pacman -Qi paru &>/dev/null ; then
   aurhelper="paru"
fi

function in {
    local pkg="$1"
    if pacman -Si "$pkg" &>/dev/null ; then
        sudo pacman -S "$pkg"
    else 
        "$aurhelper" -S "$pkg"
    fi
}

# █▄▀ █▀▀ █▄█ █▄▄ █ █▄░█ █▀▄ █ █▄░█ █▀▀ █▀
# █░█ ██▄ ░█░ █▄█ █ █░▀█ █▄▀ █ █░▀█ █▄█ ▄█
# navigation
alias c='clear'
alias cl='clear'

# list
alias  l='exa -l  --icons'
alias ls='exa -1  --icons'
alias ll='exa -la --icons'
alias ld='exa -lD --icons'

# packages
alias pacmani='sudo pacman -S' # install package
alias pacmanf='pacman -Ss' # install package
alias pacmans='pacman -Ss' # install package
alias pacmanr='sudo pacman -Rns' # uninstall package
alias pacmanup='sudo pacman -Syu' # update system/package/aur
alias pacmanls='pacman -Qs' # list installed package
alias pacmanlsa='pacman -Ss' # list availabe package
alias pacmanc='sudo pacman -Sc' # remove unused cache
alias pacmancc='pacman -Qtdq | sudo pacman -Rns -' # remove unused packages, also try > pacman -Qqd | pacman -Rsu --print -

alias yayi='yay -S'
alias yayf='yay -Ss'
alias yays='yay -Ss'
alias yayr='yay -Rcns'

# configs 
alias sourceconfig='source ~/.zshrc'
alias configzsh='cd;nvim .zshrc'
alias configkitty='cd ~/.config/kitty/; nvim kitty.conf'
alias confighypr='cd ~/.config/hypr/; nvim hyprland.conf'
alias configtmux='cd ~/.config/tmux/; nvim tmux.conf.local'
alias configvi='cd ~/.config/nvim/lua/custom/; nvim'

alias cdconfig='cd ~/.config/'
alias cdconfigvi='cd ~/.config/nvim/lua/custom/'

alias dev='cd ~/Repositories/; nvim'
alias cddev='cd ~/Repositories/;'
alias cdwebdev='cd ~/Repositories/Web-Projekts;'
alias webdev='cd ~/Repositories/Web-Projekts; nvim'
alias cdnotes='cd ~/Repositories/Notes-of-Alexandria/'
alias notes='cd ~/Repositories/Notes-of-Alexandria/; nvim'
alias devhar='cd ~/Repositories/HAR-CSE-CompSci/; nvim'
alias cddevhar='cd ~/Repositories/HAR-CSE-CompSci/;'
alias devumn='cd ~/Repositories/UMN-CSE-CompSci/; nvim'
alias cddevumn='cd ~/Repositories/UMN-CSE-CompSci/;'

# git
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# programs 
alias vi='nvim'  # gui code editor
alias vif='nvim $(fzf)'
alias nvimf='nvim $(fzf)'
alias sql='sqlite3'

alias neo='gif;cl;neofetch'
alias matrix='unimatrix -a -c red -f -n -l o -s 96'
alias top='btop'
alias gif='kitten icat --align center ~/.config/neofetch/arch-waifu-small.jpg'

# fzy (fuzzy finder)
alias ff='nvim $(fzf)'

# tmux
alias tmuxn='tmux new -t Master'
alias tmuxq='tmux kill-session'
alias tmuxqs='pkill -f tmux'

# Check if tmux is running and if not, start a new session
if [[ -z "$TMUX" && -z "$(tmux list-sessions 2>/dev/null)" ]]; then
    # If tmux is not running and no sessions exist, start a new session
    # tmux new-session -s Master
    tmux new-session -s Master \; send-keys "unimatrix -a -c red -f -n -l o -s 96; neo" Enter
elif [[ -z "$TMUX" && -n "$(tmux list-sessions 2>/dev/null)" ]]; then
    # If tmux is not running but sessions exist, attach to the first session
    # tmux attach-session -t Master
    tmux attach-session -t Master \; send-keys "unimatrix -a -c red -f -n -l o -s 96; neo" Enter
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

