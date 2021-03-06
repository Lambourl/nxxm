#!/bin/bash

if [ "$(uname)" == "Linux" ]; then
  NXXM_LINUX=1
  NXXM_URL="https://github.com/nxxm/nxxm/releases/download/v0.0.8/nxxm-v0.0.8-linux-x86_64.zip"
fi

if [ "$(uname)" == "Darwin" ]; then
  NXXM_MACOS=1
  NXXM_URL="https://github.com/nxxm/nxxm/releases/download/v0.0.8/nxxm-v0.0.8-macOS.zip"
fi

INSTALL_FOLDER="/usr/local"



abort() {
  printf " \e[91m $1 \n"
  exit 1
}

info() {
  printf "\e[1;32m ---> \e[0m $1 \n"
}

should_install_unzip() {
  if [[ $(command -v unzip) ]]; then
    return 1
  fi
}

if should_install_unzip; then
    info "unzip is needed to unzip the downloaded file, we are installing it with your package manager"
    echo "Could you validate with your password ? 😇 "
    sudo apt-get install unzip -y ||   abort "Error while installing unzip"
fi

info "Downloading nxxm..."
curl -fsSL $NXXM_URL --output ~/nxxm.zip || wget -q $NXXM_URL -O ~/nxxm.zip || abort "Could not download nxxm"
info "Installing nxxm in  $INSTALL_FOLDER/bin"
sudo unzip ~/nxxm.zip -d $INSTALL_FOLDER -x LICENSE &&  info "Nxxm is going to set up his dependencies"

mkdir $INSTALL_FOLDER/bin/install
touch $INSTALL_FOLDER/bin/install/installdeps.cpp
echo "#include <iostream> int main(){return 0;}">>$INSTALL_FOLDER/bin/install/installdeps.cpp
$INSTALL_FOLDER/bin/nxxm $INSTALL_FOLDER/bin/install 

rm ~/nxxm.zip
rm -R $INSTALL_FOLDER/bin/install
info "Nxxm and this dependencies has been successfully installed"
info "Nxxm is installing in $INSTALL_FOLDER/bin"

