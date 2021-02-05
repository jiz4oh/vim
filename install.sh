set -e

function info() { echo -e "\033[32m[info] $*\033[0m"; }
function warn() { echo -e "\033[33m[warn] $*\033[0m"; }
function error() { echo -e "\033[31m[error] $*\033[0m"; exit 1; }

check_sys() {
  OS=$(uname -s)
  if [ "${OS}" == "Darwin" ]; then
    release="Darwin"
  elif [ "${OS}" == "Linux" ]; then
    if [ -f /etc/centos-release ]; then
      release="centos"
    elif [ -f /etc/redhat-release ]; then
      release="rhel"
    elif cat /etc/issue | grep -q -E -i "centos"; then
      release="centos"
    elif cat /etc/issue | grep -q -E -i "red hat|redhat"; then
      release="rhel"
    elif cat /etc/issue | grep -q -E -i "debian"; then
      release="debian"
    elif cat /etc/issue | grep -q -E -i "ubuntu"; then
      release="ubuntu"
    elif cat /proc/version | grep -q -E -i "centos"; then
      release="centos"
    elif cat /proc/version | grep -q -E -i "red hat|redhat"; then
      release="rhel"
    elif cat /proc/version | grep -q -E -i "debian"; then
      release="debian"
    elif cat /proc/version | grep -q -E -i "ubuntu"; then
      release="ubuntu"
    elif [ -f /etc/os-release ]; then
      release=$(grep -E "^ID" /etc/os-release | awk -F '=' '{print $2}')
    else
      release="Unknown"
    fi
  else
    release="${OS}"
  fi
}

# package manager install
pm_install() {
  err_log_path=install_err.log
  err_msg="Some thing is wrong, please run\n\n cat $err_log_path \n\nto view."
  case $release in
  debian | ubuntu | devuan)
    for i in $*; do
      info "Installing $i"
      apt-get install -y "$i" -qq --no-install-recommends >/dev/null 2>> $err_log_path || error $err_msg
    done
    ;;
  centos | rhel)
    for i in $*; do
      info "Installing $i"
      yum install -y "$i" -q >/dev/null 2>> $err_log_path || error $err_msg
    done
    ;;
  Darwin)
    for i in $*; do
      info "Installing $i"
      brew ls --versions "$i" >/dev/null || brew install "$i" -q >/dev/null 2>>$err_log_path || error $err_msg
    done
    ;;
  *)
    error 'Unknown system, exit!'
    ;;
  esac
}

install(){
  pm_install git
  curl -fsSL https://cdn.jsdelivr.net/gh/jiz4oh/vim@master/vimrc > ~/.vim/vimrc
  curl -fsSL https://cdn.jsdelivr.net/gh/jiz4oh/vim@master/vimrc.bundles > ~/.vim/vimrc.bundles
  cp ~/.vimrc ~/.vimrc.bak
  curl -fsSL https://cdn.jsdelivr.net/gh/jiz4oh/vim@master/vimrc.entire > ~/.vimrc
}

check_sys
install
