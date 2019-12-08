typeset -U path

HISTFILE="$ZDOTDIR"/histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob
bindkey -e

bindkey "\e[3~" delete-char

fpath+="$HOME/.local/share/zsh/functions"

autoload -U add-zsh-hook
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit

path+=("$HOME/.local/bin")
path+=("$XDG_DATA_HOME/cargo/bin")

if [ ! -d $NVM_DIR ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | zsh
fi

if [ ! -d $ZPLUG_HOME ]; then
  git clone https:://github.com/zplug/zplug $ZPLUG_HOME
fi

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -s "/usr/share/doc/find-the-command/ftc.zsh" ] && \. "/usr/share/doc/find-the-command/ftc.zsh"
[ -s "$XDG_DATA_HOME/rvm/scripts/rvm" ] && \. "$XDG_DATA_HOME/rvm/scripts/rvm"

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

load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

[ -s /usr/bin/value ] && complete -o nospace -C /usr/bin/vault vault

zstyle :omz:plugins:keychain agents gpg,ssh

source "$HOME/.zsh_alias"

# Load fzf key bindings
[ -s /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh

function clear-scrollback-buffer {
  # clear screen
  clear
  # clear buffer. The following sequence code is available for xterm.
  printf '\e[3J'
  # .reset-prompt: bypass the zsh-syntax-highlighting wrapper
  # https://github.com/sorin-ionescu/prezto/issues/1026
  # https://github.com/zsh-users/zsh-autosuggestions/issues/107#issuecomment-183824034
  # -R: redisplay the prompt to avoid old prompts being eaten up
  # https://github.com/Powerlevel9k/powerlevel9k/pull/1176#discussion_r299303453
  zle .reset-prompt && zle -R
}

zle -N clear-scrollback-buffer
bindkey '^L' clear-scrollback-buffer
