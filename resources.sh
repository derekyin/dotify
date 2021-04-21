#! Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"

function ok() {
  echo -e "$COL_GREEN [ok]$COL_RESET "$1
}

function bot() {
  echo -e "\n$COL_GREEN\[._.]/$COL_RESET - "$1
}

function running() {
  echo -e "$COL_CYAN ⇒ $COL_RESET "$1": "
}

function action() {
  echo -e "\n$COL_YELLOW [action]:$COL_RESET\n ⇒ $1"
}

function warn() {
  echo -e "$COL_YELLOW [warning]$COL_RESET "$1
}

function error() {
  echo -e "$COL_RED [error]$COL_RESET "$1
}

function yes_or_no() {
  echo -n "\n$COL_MAGENTA $1 $COL_RESET(y/n) "
  read response
}

function confirmed() {
  if [[ "$response" =~ ^[Yy]$ ]]; then
    return 0
  fi
  return 1
}

function set_computer_info() {
  echo -e "$COL_MAGENTA Enter your computer name$COL_RESET: "
  read cpname

  sudo scutil --set ComputerName "$cpname"
  sudo scutil --set HostName "$cpname"
  sudo scutil --set LocalHostName "$cpname"
}

function SSH_Keygen() {
  echo -n "\n$COL_MAGENTA set your email$COL_RESET:"
  read email
  ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519 -C $email
  eval "$(ssh-agent -s)"
  cat sshconfig > ~/.ssh/config
  ssh-add -K ~/.ssh/id_ed25519
}

function symlink_dot_files() {
   dir="$(git rev-parse --show-toplevel)/dotfiles"

   for file in aliases functions gitattributes gitconfig gitignore zshrc LS_COLORS; do
     echo "Creating symlink to $file in home directory."
     ln -sfnv $dir/.$file ~/.$file
   done
}
