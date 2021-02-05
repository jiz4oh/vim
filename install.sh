set -e

function info() { echo -e "\e[32m[info] $*\e[0m"; }
function warn() { echo -e "\e[33m[warn] $*\e[0m"; }
function error() { echo -e "\e[31m[error] $*\e[0m"; exit 1; }

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
  case $release in
  debian | ubuntu | devuan)
    for i in $*; do
      info "Installing $i"
      apt-get install -y "$i" -qq --no-install-recommends >/dev/null 2>> $err_log_path
      if [[ !$? ]];then
        error "Some thing is wrong, please run\n\n cat $err_log_path \n\nto view."
      fi
    done
    ;;
  centos | rhel)
    for i in $*; do
      info "Installing $i"
      yum install -y "$i" -q >/dev/null 2>> $err_log_path
      if [[ !$? ]];then
        error "Some thing is wrong, please run\n\n cat $err_log_path \n\nto view."
      fi 
    done
    ;;
  Darwin)
    for i in $*; do
      info "Installing $i"
      brew install "$i" -q >/dev/null 2>>$err_log_path
      if [[ !$? ]]; then
        error "Some thing is wrong, please run\n\n cat $err_log_path \n\nto view."
      fi
    done
    ;;
  *)
    error 'Unknown system, exit!'
    ;;
  esac
}

install(){
  pm_install git
  curl -fsSLo ~/.vim/vimrc https://cdn.jsdelivr.net/gh/jiz4oh/vim@master/vimrc
  curl -fsSLo ~/.vim/vimrc.bundles https://cdn.jsdelivr.net/gh/jiz4oh/vim@master/vimrc.bundles
  curl -fsSLo ~/.vim/.vimrc https://cdn.jsdelivr.net/gh/jiz4oh/vim@master/vimrc.entire
}

check_sys
install
