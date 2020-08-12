#!/bin/sh
#
# Copyright 2014 Google Inc.
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


# Packages:
# 1. ssh-copy-id
# 2. ack
# 3. sshfs

# Homebrew for Mac OS X.
if command -v 'brew' &>/dev/null; then
  BREWED_PACKAGES=""
  BREWED_HEAD_PACKAGES=""

  if [ -f `brew --prefix`/etc/bash_completion ]; then
    source `brew --prefix`/etc/bash_completion
  else
    echo "Installing bash-completion"
    #brew install bash-completion
    BREWED_PACKAGES="$BREWED_PACKAGES bash-completion"
  fi
  if [ -f `brew --prefix`/etc/autojump.sh ]; then
    source `brew --prefix`/etc/autojump.sh
  elif [ -f `brew --prefix`/etc/autojump ]; then
    source `brew --prefix`/etc/autojump
  else
    echo "Installing autojump"
    #brew install autojump
    BREWED_PACKAGES="$BREWED_PACKAGES autojump"
  fi

  # For packages that have the same names as their executables.
  for p in 'tig' 'tree'
  do
    if [ ! command -v p &>/dev/null ]; then
      echo "Installing $p"
      BREWED_PACKAGES="$BREWED_PACKAGES $p"
    fi
  done

  # For HEAD packages that have the same names as their executables.
  for p in 'node'
  do
    if [ ! command -v p &>/dev/null ]; then
      echo "Installing $p"
      BREWED_HEAD_PACKAGES="$BREWED_HEAD_PACKAGES $p"
    fi
  done

  # Special cases.
  if [ ! command -v 'gpg' &>/dev/null ]; then
    echo "Installing gnupg"
    BREWED_PACKAGES="$BREWED_PACKAGES gnupg"
  fi

  # Now install.
  if [ "$BREWED_PACKAGES" != "" ]; then
    brew install $BREWED_PACKAGES
  fi
  if [ "$BREWED_HEAD_PACKAGES" != "" ]; then
    brew install --HEAD $BREWED_HEAD_PACKAGES
  fi

  # Specific packages
  EMACS_VERSION=$(emacs --version | grep '^GNU Emacs 24\..*')
  if [[ $? -ne 0 ]]; then
    brew install --HEAD --use-git-head emacs
  fi
fi
