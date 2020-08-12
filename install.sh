#!/bin/sh
#
# Copyright 2012 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Author: yesudeep@google.com (Yesudeep Mangalapilly)

PWD=`pwd`

git submodule update --init --recursive

# Vim configuration.
VIM_DIR=${HOME}/.vim

ln -s ${PWD}/vimrc ${HOME}/.vimrc
ln -s ${PWD}/hgrc ${HOME}/.hgrc
ln -s ${PWD}/eclimrc ${HOME}/.eclimrc

echo "Please install cmake"
mkdir -p ${VIM_DIR}/autoload ${VIM_DIR}/ftplugin
curl -fLo ${VIM_DIR}/autoload/plug.vim \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall
cd ~/.vim/autoload && curl -O https://raw.github.com/nsf/gocode/master/vim/autoload/gocomplete.vim
cd ~/.vim/ftplugin && curl -O https://raw.github.com/nsf/gocode/master/vim/ftplugin/go.vim
cd ~/.vim/plugged/YouCompleteMe && ./install.sh --clang-completer


# Fish shell configuration.
mkdir -p ~/.config/fish
ln -s ~/.dotfiles/config/fish/functions ~/.config/fish/functions
ln -s ~/.dotfiles/config/fish/config.fish ~/.config/fish/config.fish
ln -s ~/.dotfiles/path_environment ~/.path_environment
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
