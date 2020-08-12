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

#    PS1="[\t][\u@\h:\w]\$ "
export CLICOLOR=1
export LSCOLORS exfxcxdxbxegebabagacad

# Shortcuts for ls
alias dir='ls -ahlF'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alhF'
alias ls='ls -C'

# MD5 checksum aliases.
alias md5='md5 -r'
alias md5sum='md5 -5'

# Other aliases
alias grep='grep -I --color -n'
#alias open='open'
alias rgrep='rgrep -I --color -n'

# Applications
alias diffmate='git diff | mate'
alias emacs='emacs -nw'
