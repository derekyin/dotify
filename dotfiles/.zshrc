[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

# shellcheck disable=SC2034
DEFAULT_USER=adi

export ZSH="/Users/adi/.oh-my-zsh"

export EDITOR=nano
export PATH=$HOME/.npm-global/bin:$HOME/.krew/bin:/usr/local/sbin:$PATH

export DOCKER_BUILDKIT=1

# shellcheck disable=SC2034
ZSH_THEME="agnoster"

export UPDATE_ZSH_DAYS=5

# shellcheck disable=SC2034
plugins=(
  autojump
  autoupdate
  colorize
  colored-man-pages
  docker
  fast-syntax-highlighting
  git
  history-substring-search
  vscode
  you-should-use
  zsh-autosuggestions
)

# shellcheck disable=SC1090
source $ZSH/oh-my-zsh.sh

BREW_PREFIX=$(brew --prefix)
# shellcheck disable=SC1091
if [ -f "${BREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc" ]; then
  source "$BREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc";
fi

# shellcheck disable=SC1091
if [ -f "$BREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc" ]; then
  source "$BREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc";
fi

# shellcheck disable=SC1090
for file in ~/.{aliases,functions}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

#hub => git
if [ -x "$(command -v hub)" ]; then
  eval "$(hub alias -s)"
fi

if [ -x "$(command -v rbenv)" ]; then
  eval "$(rbenv init -)"
fi

eval $(gdircolors $HOME/.LS_COLORS)

export KUBECONFIG=/Users/adi/.kube/config.shopify.cloudplatform

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
[[ -f /opt/dev/sh/chruby/chruby.sh ]] && type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; }

if [ -x "$(command -v gimme)" ]; then
  eval "$(gimme 1.18beta1)" > /dev/null 2>&1
  export GOBIN=$GOROOT/bin
  export GOPATH=$HOME
  export GO111MODULE=on
  export GOPRIVATE="github.com/Shopify/*"
fi
