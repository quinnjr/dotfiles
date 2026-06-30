typeset -U path

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Auto-launch tmux
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
if command -v tmux &> /dev/null && \
   [[ -z "$TMUX" ]] && \
   [[ -z "$INSIDE_EMACS" ]] && \
   [[ -z "$VSCODE_TERMINAL" ]] && \
   [[ "$TERM_PROGRAM" != "vscode" ]] && \
   [[ -z "$CURSOR_TERMINAL" ]] && \
   [[ -t 1 ]]; then
  # Attach to existing session or create new one
  tmux attach-session -t main 2>/dev/null || tmux new-session -s main
fi

HISTFILE="$XDG_CACHE_HOME"/zsh_histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob
bindkey -e

bindkey '\e[3~' delete-char

fpath+=("$XDG_DATA_HOME/zsh/functions")

autoload -U add-zsh-hook
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit
autoload -U is-at-least
autoload -U clear-scrollback-buffer
autoload -U load-nvm

path+=("$HOME/.local/bin" "$XDG_DATA_HOME/cargo/bin" "/var/lib/snapd/snap/bin" "$XDG_DATA_HOME/pnpm" "$PYENV_ROOT/bin" "/opt/dart-sdk/bin" "$BUN_INSTALL/bin" "/opt/mssql-tools18/bin" "/snap/bin")

[ -s "$HOME/.profile" ] && \. "$HOME/.profile"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -s "/usr/share/doc/find-the-command/ftc.zsh" ] && \. "/usr/share/doc/find-the-command/ftc.zsh"
[ -d "$XDG_DATA_HOME/pyenv" ] && eval "$(pyenv init -)"
[ -d "$(pyenv root)/plugins/pyenv-virtualenv" ] && eval "$(pyenv virtualenv-init -)"
[ -d "$XDG_DATA_HOME/rvm" ] && \. "$XDG_DATA_HOME/rvm/scripts/rvm"
[ -s "$XDG_DATA_HOME/zsh/alias" ] && \. "$XDG_DATA_HOME/zsh/alias"

source "$ZPLUG_HOME/init.zsh"

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting'

zplug 'b4b4r07/enhancd', use:init.sh
zplug 'Tarrasch/zsh-autoenv'

omz_plugins=(
  'plugins/colored-man-pages'
  'plugins/command-not-found'
  'plugins/extract'
  'plugins/git'
  'plugins/git-extras'
  'plugins/git-flow-avh'
  'plugins/gitignore'
)

for plugin in $omz_plugins; do
  zplug $plugin, from:oh-my-zsh
done

zplug 'themes/gallifrey', from:oh-my-zsh, as:theme

if ! zplug check; then
  zplug install;
fi

zplug load

# Make enhancd fall back to builtin cd when there's no TTY
# (interactive filters like fzf/fzy require a terminal)
if (( ${+functions[__enhancd::cd]} )); then
  functions[__enhancd::cd::orig]="${functions[__enhancd::cd]}"
  __enhancd::cd() {
    if [[ ! -t 1 ]]; then
      builtin cd "$@"
    else
      __enhancd::cd::orig "$@"
    fi
  }
fi

# SSH agent: gcr-ssh-agent owns SSH_AUTH_SOCK (set in ~/.zshenv and
# ~/.config/environment.d/ssh.conf); key passphrases live in the GNOME login
# keyring. Use the gcr askpass so prompts integrate with the keyring.
export SSH_ASKPASS=/usr/lib/gcr4-ssh-askpass
export SSH_ASKPASS_REQUIRE=prefer
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts \
  'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

eval "$(direnv hook zsh)"

zle -N clear-scrollback-buffer
bindkey '^L' clear-scrollback-buffer

# Load Angular CLI autocompletion.
source <(ng completion script)

[[ /usr/bin/kubectl ]] && source <(kubectl completion zsh)

# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin

# pnpm path setup
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Cargo env
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# bun completions
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# Aliases
alias gitclean='git fetch -p && git branch -vv | grep ": gone]" | awk "{print \$1}" | xargs git branch -D'
alias bedrock="source ~/.local/bin/toggle-bedrock"

# Remove interactive flags from core commands
unalias rm mv cp 2>/dev/null

# Wrapper for rg: AI tools keep passing grep's -E flag which rg treats as --encoding.
# Strip -E and its argument so rg doesn't choke.
rg() {
  local args=()
  while (( $# )); do
    case "$1" in
      -E) shift ;; # drop -E and its value (encoding arg)
      *)  args+=("$1") ;;
    esac
    shift
  done
  command rg "${args[@]}"
}

[ -f "$HOME/.local/share/dotfiles/zsh/.secrets" ] && source "$HOME/.local/share/dotfiles/zsh/.secrets"

# Refresh Advita AWS MFA short-term credentials using the TOTP secret in `pass`.
advita-aws-login() {
  ~/.local/bin/aws-mfa-auto --profile advita --secret "$(pass show aws/mfa-secret)" "$@"
}

# claude-profile: manage Claude Code configuration profiles
. "${XDG_DATA_HOME:-$HOME/.local/share}/claude-profile/claude-profile.sh"

# ripgrep: consume GNU grep -E so it behaves like --extended-regexp
. "$HOME/.local/share/ripgrep-alias/rg.sh"

# zoxide: smart cd replacement with frecency-based directory jumping
eval "$(zoxide init zsh --cmd cd)"

# opencode
export PATH=/home/joseph/.opencode/bin:$PATH
