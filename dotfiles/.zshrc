[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

# shellcheck disable=SC2034
DEFAULT_USER=$USER

export ZSH="$HOME/.oh-my-zsh"
export GOPATH=$HOME
export GO111MODULE=on

export EDITOR=nano
export PATH=$HOME/.npm-global/bin:$GOPATH/bin:$HOME/.krew/bin:/usr/local/sbin:$PATH

export DOCKER_BUILDKIT=1

# shellcheck disable=SC2034
ZSH_THEME="agnoster"

export UPDATE_ZSH_DAYS=5

export FZF_BASE=$(command -v fzf)
# shellcheck disable=SC2034
plugins=(
  fzf
  1password
  autojump
  autoupdate
  colorize
  colored-man-pages
  docker
  fast-syntax-highlighting
  gh
  git
  history-substring-search
  ripgrep
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

export KUBECONFIG=$HOME/.kube/config
