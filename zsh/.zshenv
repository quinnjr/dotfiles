export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS='/usr/local/share:/usr/share'
export XDG_CONFIG_DIRS="/etc/xdg:$XDG_CONFIG_HOME/xdg"

export NODE_ENV='development'

export BROWSER='chromium'
export EDITOR='vim'
export PAGER='less'
export VISUAL='atom'

export _JAVA_OPTIONS='-Dswing.aatext=true -Dsun.java2d.uiScale=2'

export CC="/usr/bin/musl-clang"
export CXX="/usr/bin/clang++"
export CFLAGS="-Wall -Wpedantic -fPIC -O2 -std=gnu11"

export ANSIBLE_NOCOWS='1'
export ATOM_HOME="$XDG_DATA_HOME"/atom

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CCACHE_DIR="$XDG_CACHE_HOME"/ccache
export CHROMIUM_USER_FLAGS="--force-device-scale-factor=2 --cipher-suite-blacklist=0x0001,0x0002,0x0004,0x0005,0x0017,0x0018,0xc002,0xc007,0xc00c,0xc011,0xc016,0xff80,0xff81,0xff82,0xff83"

export DVDCSS_CACHE="$XDG_DATA_HOME"/dvdcss

export ENHANCD_DIR="$XDG_DATA_HOME"/enhancd

export GIT_MERGE_AUTOEDIT='no'
export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg
export GOBIN="$HOME/Projects/go-workspace/bin"
export GOPATH="$HOME/Projects/go-workspace"
export GOSRC="$HOME/Projects/go-workspace/src"
export GTK_RC_FILES="$XDG_CONFIG_HOME"/gtk-1.0/gtkrc
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey

export MAKEFLAGS="-j $(nproc)"
export MPLAYER_HOME="$XDG_CONFIG_HOME"/mplayer
export MYSQL_HISTFILE="$XDG_DATA_HOME"/mysql_history

export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export NVM_DIR="$XDG_DATA_HOME"/nvm

export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_SCREEN_SCALE_FACTORS=1

export RANDFILE="$XDG_RUNTIME_DIR"/rnd
export RUST_SRC_PATH="$XDG_DATA_HOME/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

export SAL_USE_VCLPLUGIN='gtk'
export SCREENRC="$XDG_CONFIG_HOME"/screen/screenrc

export RXVT_SOCKET="$XDG_RUNTIME_DIR"/urxvtd

export VIMINIT='let $VIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $VIMRC'
export VIMRC="$XDG_CONFIG_HOME/vim/vimrc"

export WGETRC="$XDG_CONFIG_HOME/wgetrc"

export ZPLUG_CACHE_DIR="$XDG_CACHE_HOME"/zplug
export ZPLUG_HOME="$XDG_DATA_HOME"/zsh/zplug

export VAULT_ADDR='http://127.0.0.1:8200'
