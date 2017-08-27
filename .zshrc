setopt EXTENDED_GLOB
setopt AUTO_CD
unsetopt FLOW_CONTROL

HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=$HOME/.zhistory
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_EXPIRE_DUPS_FIRST

autoload -U compinit
compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' # case insensitive
zstyle ':completion:*' menu select
setopt completealiases

alias ls='ls --color=auto'
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
alias devmon='devmon --no-gui'
alias fixsound="amixer -c 0 cset 'numid=10' 1"
alias pdfgrep="pdfgrep --cache"
function serve-ghcjs {
    dir=$(dirname $(cabal-plan list-bin | grep "exe:$1" | awk '{print $2}'));
    warp -d "${dir}/$1.jsexe";
}

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

bindkey -e

# use pkgfile
source /usr/share/doc/pkgfile/command-not-found.zsh

# Base16 Shell
BASE16_SCHEME="monokai"
BASE16_SHELL="$HOME/.config/base16-shell/base16-$BASE16_SCHEME.dark.sh"
[[ -s $BASE16_SHELL ]] && . $BASE16_SHELL

# fix tramp in emacs
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ '

setopt prompt_subst

autoload -U bashcompinit && bashcompinit
eval "$(stack --bash-completion-script "$(which stack)")"

# OPAM configuration
. /home/moritz/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

source '/home/moritz/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zplugin load "mafredri/zsh-async"
zplugin load "sindresorhus/pure"
zplugin load "zsh-users/zsh-syntax-highlighting"
zplugin load "zsh-users/zsh-history-substring-search"
zplugin snippet "https://raw.githubusercontent.com/rupa/z/master/z.sh"

bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
