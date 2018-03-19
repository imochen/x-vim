APP_NAME='x-vim'
APP_PATH="$HOME/.x-vim"
REPO_URI='ssh://git@lorna.imochen.com:3022/mochen/x-vim.git'
REPO_BRANCH='master'

PLUG_URI='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

debug_mode='1'

msg() {
  printf '%b\n' "$1" >&2
}

success() {
  if [ "$ret" -eq '0' ]; then
    msg "\33[32m[✔]\33[0m ${1}${2}"
  fi
}

error() {
  msg "\33[31m[✘]\33[0m ${1}${2}"
  exit 1
}

debug() {
  if [ "$debug_mode" -eq '1' ] && [ "$ret" -gt '1' ]; then
    msg "An error occurred in function \"${FUNCNAME[$i+1]}\" on line ${BASH_LINENO[$i+1]}, we're sorry for that."
  fi
}

program_exists() {
  local ret='0'
  command -v $1 >/dev/null 2>&1 || { local ret='1'; }

  if [ "$ret" -ne 0 ]; then
    return 1
  fi

  return 0
}

program_must_exists() {
  program_exists $1
  
  if [ "$?" -ne 0 ]; then
    error "You must have '$1' installed to continue."
  fi
}

variable_set() {
  if [ -z "$1" ]; then
    error "You must have your HOME environmental variable set to continue."
  fi
}

lnif() {
  if [ -e "$1" ]; then
    ln -sf "$1" "$2"
  fi
  ret="$?"
  debug
}

do_backup() {
  if [ -e "$1" ] || [ -e "$2" ] || [ -e "$3" ]; then
    msg "Attempting to back up your original vim configuration."
    today=`date +%Y%m%d_%s`
    for i in "$1" "$2" "$3"; do
      [ -e "$i" ] && [ ! -L "$i" ] && mv -v "$i" "$i.$today";
    done
    ret="$?"
    success "Your original vim configuration has been backed up."
    debug
  fi
}

sync_repo() {
  local repo_path="$1"
  local repo_uri="$2"
  local repo_branch="$3"
  local repo_name="$4"

  msg "Trying to update $repo_name"
  
  if [ ! -e "$repo_path" ]; then
    mkdir -p "$repo_path"
    git clone -b "$repo_branch" "$repo_uri" "$repo_path"
    ret="$?"
    success "Successfully cloned $repo_name."
  else
    cd "$repo_path" && git pull origin "$repo_branch"
    ret="$?"
    success "Successfully updated $repo_name"
  fi
  debug
}

plug_install() {
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs $PLUG_URI
  success "Install plug success."
  debug
}

setup_plug() {
  local system_shell="$SHELL"
  export SHELL='/bin/sh'

  vim \
    "+PlugInstall!" \
    "+PlugClean" \
    "+qall"

  export SHELL="$system_shell"

  success "Now updating/installing plugins using Plug"
  debug
}

create_symlinks() {
  local source_path="$1"
  local target_path="$2"

  lnif "$source_path/.vimrc"    "$target_path/.vimrc"
  lnif "$source_path/.vim"      "$target_path/.vim"
  
  touch "$target_path/.vimrc.local"

  ret="$?"
  success "Setting up vim symlinks."
  debug
}


variable_set "$HOME"
program_must_exists "vim"
program_must_exists "git"

do_backup     "$HOME/.vim" \
              "$HOME/.vimrc" \

sync_repo     "$APP_PATH" \
              "$REPO_URI" \
              "$REPO_BRANCH" \
              "$APP_NAME" 

create_symlinks "$APP_PATH" \
                "$HOME"

plug_install

setup_plug

msg             "\nThanks for installing $APP_PATH."
msg             "© `date +%Y`"


























