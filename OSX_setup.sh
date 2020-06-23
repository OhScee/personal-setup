#!/bin/bash
function install_pip() {
  sudo easy_install pip
  sudo pip install --upgrade pip
}

function install_python_dependancies() {
  pip install -r requirements_py2.txt 
  pip3 install -r requirements_py3.txt 
}

function install_brew() {
  if brew; then 
    echo "Brew Already Installed..."
  else 
    echo "Installing Brew"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi

  brew upgrade
  install_brew_packages()
}

function install_brew_packages() {
  brew install $(< ./brew_requirements.txt )
  brew install python3
}

function oh_my_zsh() {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function install_neovim() {
  curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
  tar xzf nvim-macos.tar.gz
  ./nvim-osx64/bin/nvim
}

function install_kitty() {
  git clone https://github.com/kovidgoyal/kitty && kitty
  make app
}

oh_my_zsh() && install_pip() && install_brew() && install_python_dependancies() && install_kitty() && install_neovim()
