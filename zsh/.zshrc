typeset -U path

HISTFILE="$ZDOTDIR"/histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob
bindkey -e

bindkey "\e[3~" delete-char

fpath+="$XDG_DATA_HOME/zsh/functions"

autoload -U add-zsh-hook
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit

path+=("$HOME/.local/bin")
path+=("$XDG_DATA_HOME/cargo/bin")

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -s "/usr/share/doc/find-the-command/ftc.zsh" ] && \. "/usr/share/doc/find-the-command/ftc.zsh"
[ -s "$XDG_DATA_HOME/rvm/scripts/rvm" ] && \. "$XDG_DATA_HOME/rvm/scripts/rvm"

source "$XDG_DATA_HOME/zsh/alias"

source "$ZPLUG_HOME/init.zsh"

zplug "zplug/zplug", hook-build:"zplug --self-manage"

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"

zplug "b4b4r07/enhancd", use:init.sh

zplug "plugins/archlinux", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/cp", from:oh-my-zsh
zplug "plugins/dotenv", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/git-extras", from:oh-my-zsh
zplug "plugins/git-flow-avh", from:oh-my-zsh
zplug "plugins/gitignore", from:oh-my-zsh
zplug "plugins/golang", from:oh-my-zsh
zplug "plugins/heroku", from:oh-my-zsh
zplug "plugins/jump", from:oh-my-zsh
zplug "plugins/keychain", from:oh-my-zsh
zplug "plugins/nvm", from:oh-my-zsh
zplug "plugins/rust", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/systemd", from:oh-my-zsh
zplug "plugins/vagrant", from:oh-my-zsh

zplug "themes/gallifrey", from:oh-my-zsh, as:theme

if ! zplug check; then
  zplug install;
fi

zplug load

zstyle :omz:plugins:keychain agents gpg,ssh
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts \
  'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

if [ -d "$NVM_DIR" ]
  add-zsh-hook chpwd load-nvmrc
  load-nvmrc
fi

[ -s /usr/bin/value ] && complete -o nospace -C /usr/bin/vault vault
[ -s /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh

zle -N clear-scrollback-buffer
bindkey '^L' clear-scrollback-buffer
