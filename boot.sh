DOWNLOADPATH = "$HOME/.x-vim"
REPO_URL="https://lorna.imochen.com/mochen/x-vim.git"


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

if [ ! -e "$DOWNLOADPATH" ]; then
  mkdir -p "$REPO_URL"
  git clone "$REPO_URL" "$DOWNLOADPATH"
  success "Successfully cloned x-vim"
else
  cd "$DOWNLOADPATH" && git pull origin master
  success "Successfully updated x-vim"
fi

