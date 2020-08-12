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

# Packages pending:
# keychain tree tig aptitude emacs node autojump bash-completion ack-grep sshfs

# if command -v 'apt-get' &>/dev/null; then
#   APT_PACKAGES=""
#   BREWED_HEAD_PACKAGES=""

#   if [ -f `brew --prefix`/etc/bash_completion ]; then
#     source `brew --prefix`/etc/bash_completion
#   else
#     echo "Installing bash-completion"
#     APT_PACKAGES="$APT_PACKAGES bash-completion"
#   fi
#   if [ -f `brew --prefix`/etc/autojump ]; then
#     source `brew --prefix`/etc/autojump
#   else
#     echo "Installing autojump"
#     APT_PACKAGES="$APT_PACKAGES autojump"
#   fi

#   # For packages that have the same names as their executables.
#   for p in 'tig' 'tree'
#   do
#     if [ ! command -v p &>/dev/null ]; then
#       echo "Installing $p"
#       APT_PACKAGES="$APT_PACKAGES $p"
#     fi
#   done

#   # For HEAD packages that have the same names as their executables.
#   for p in 'node'
#   do
#     if [ ! command -v p &>/dev/null ]; then
#       echo "Installing $p"
#       BREWED_HEAD_PACKAGES="$BREWED_HEAD_PACKAGES $p"
#     fi
#   done

#   # Special cases.
#   if [ ! command -v 'gpg' &>/dev/null ]; then
#     echo "Installing gnupg"
#     APT_PACKAGES="$APT_PACKAGES gnupg"
#   fi

#   # Now install.
#   if [ "$APT_PACKAGES" != "" ]; then
#     brew install $APT_PACKAGES
#   fi
#   if [ "$BREWED_HEAD_PACKAGES" != "" ]; then
#     brew install --HEAD $BREWED_HEAD_PACKAGES
#   fi

#   # Specific packages
#   EMACS_VERSION=$(emacs --version | grep '^GNU Emacs 24\..*')
#   if [[ $? -ne 0 ]]; then
#     sudo apt-get build-dep emacs-snapshot
#     git clone git://savannah url
#     cd emacs
#     ./configure && make && sudo make install
#   fi

# fi


# autojump
#
# Please add the line to ~/.bashrc :
# [[ -s ~/.autojump/etc/profile.d/autojump.bash ]] && source ~/.autojump/etc/profile.d/autojump.bash

# if [ -f "/usr/share/autojump/autojump.bash" ]; then
#   source /usr/share/autojump/autojump.bash
# fi
