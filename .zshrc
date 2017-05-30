setopt extended_glob

# history
HISTFILE=$HOME/.zhistory       # enable history saving on shell exit
setopt APPEND_HISTORY          # append rather than overwrite history file.
HISTSIZE=1000000                 # lines of history to maintain memory
SAVEHIST=1000000                 # lines of history to maintain in history file.
setopt HIST_EXPIRE_DUPS_FIRST  # allow dups, but expire old ones when I hit HISTSIZE
setopt EXTENDED_HISTORY        # save timestamp and runtime information

setopt autocd
autoload -U compinit
compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

setopt completealiases
alias ls='ls --color=auto'
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
alias devmon='devmon --no-gui'
alias fixsound="amixer -c 0 cset 'numid=10' 1"
alias pdfgrep="pdfgrep --cache"

export EDITOR=emacsclient
export MAILDIR=~/mail
export BROWSER=firefox
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export _JAVA_AWT_WM_NONREPARENTING=1
export SSH_AUTH_SOCK=~/.gnupg/S.gpg-agent.ssh.proxied
export MOZ_USE_XINPUT2=1

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

source ~/.zplug/init.zsh
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "rupa/z", use:"z.sh"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load --verbose
export PURE_GIT_PULL=0

setopt prompt_subst
# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
zstyle ':filter-select:highlight' matched fg=green
zstyle ':filter-select' extended-search yes
zstyle ':filter-select' rotate-list yes

autoload -U bashcompinit && bashcompinit
eval "$(stack --bash-completion-script "$(which stack)")"

# OPAM configuration
. /home/moritz/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

export GOPATH=~/go
