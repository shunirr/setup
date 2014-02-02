#!/bin/bash

reload_zsh_profile() {
  source ~/.zshenv
  source ~/.zshrc
}

copy_local_bin() {
  if [ ! -d "/usr/local/bin" ]; then
    mkdir -p "/usr/local/bin"
  fi
  if [ ! -f "/usr/local/bin/$(basename \"$1\")" ]; then
    cp "$1" "/usr/local/bin/$(basename $1)"
  fi
}

git_clone() {
  CLONE_PATH=$1
  GIT_URL=$2
  if [ ! -d $CLONE_PATH ]; then
    git clone $GIT_URL $CLONE_PATH
  fi
}

sudo apt-get -y update
sudo apt-get -y upgrade

sudo apt-get -y install \
  build-essential \
  bison \
  libreadline6-dev \
  curl \
  git-core \
  zlib1g-dev \
  libssl-dev \
  libyaml-dev \
  libsqlite3-dev \
  sqlite3 \
  libxml2-dev \
  libxslt1-dev \
  autoconf \
  libncurses5-dev \
  vim \
  zsh \
  gnome-tweak-tool \
  unity-tweak-tool

sudo chsh -s /bin/zsh shunirr

pushd ~/
  git_clone "~/.rbenv", "https://github.com/sstephenson/rbenv.git"
  git_clone "~/.rbenv/plugins/ruby-build", "https://github.com/sstephenson/ruby-build.git"
  
  # dot-files
  mkdir -p ~/dev
  pushd ~/dev
    git_clone "dot-files", "git@github.com:shunirr/dot-files.git"
    pushd dot-files
      make
      make install
      reload_zsh_profile
    popd
  popd
popd

# rbenv install 2.1.0
# rbenv install 2.0.0-p353
# rbenv install 1.9.3-p484

copy_local_bin "./cpufreq"
copy_local_bin "./powersave"


