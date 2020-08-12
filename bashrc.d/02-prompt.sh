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
#
# Based on:
# 1. https://github.com/thomasvs/bash-prompt-git/blob/master/git
# 2. http://jonmaddox.com/2008/03/13/show-your-git-branch-name-in-your-prompt/
# 3. http://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html

# Shell-escapes color codes given as arguments.
#
# :param 1:
#    Color code.
# :returns:
#    Shell-escaped color code.
function escape() {
  echo "\[\033[$1\]"
}

# Formatting
FORMAT_BOLD_ON=$(escape 1m)
FORMAT_BOLD_OFF=$(escape 22m)
FORMAT_BLINK_ON=$(escape 5m)
FORMAT_BLINK_OFF=$(escape 25m)
FORMAT_REVERSE_ON=$(escape 7m)
FORMAT_REVERSE_OFF=$(escape 27m)

# Colors based on http://pastie.org/154354
# COLOR_NAME='\[\033[ color_code m\]'
COLOR_RESET=$(escape 0m)

# Foreground colors
COLOR_FG_DEFAULT=$(escape 39m)
COLOR_FG_BLACK=$(escape 30m)
COLOR_FG_RED=$(escape 31m)
COLOR_FG_GREEN=$(escape 32m)
COLOR_FG_BROWN=$(escape 33m)
COLOR_FG_BLUE=$(escape 34m)
COLOR_FG_PURPLE=$(escape "35m")
COLOR_FG_MAGENTA=$(escape "1;35m")
COLOR_FG_CYAN=$(escape 36m)
COLOR_FG_WHITE=$(escape 37m)

# Background colors
COLOR_BG_DEFAULT=$(escape 49m)
COLOR_BG_BLACK=$(escape 40m)
COLOR_BG_RED=$(escape 41m)
COLOR_BG_GREEN=$(escape 42m)
COLOR_BG_BROWN=$(escape 43m)
COLOR_BG_BLUE=$(escape 44m)
COLOR_BG_PURPLE=$(escape 45m)
COLOR_BG_MAGENTA=$(escape "1;45m")
COLOR_BG_CYAN=$(escape 46m)
COLOR_BG_WHITE=$(escape 47m)


function is_submodule() {
  local git_dir parent_git module_name path strip
  # Find the root of this git repo, then check if its parent dir is also a repo
  git_dir="$(git rev-parse --show-toplevel)"
  parent_git="$(cd "$git_dir/.." && git rev-parse --show-toplevel 2> /dev/null)"

  if [[ -n $parent_git ]]; then
    strip=$((${#parent_git} + 1))
    module_name=${git_dir:$strip}

    # TODO(yesudeep): This bit is causing GDM on Ubuntu 12.04 to not login.
    # Disabled temporarily.

    # # List all the submodule paths for the parent repo
    # while read path
    # do
    #   if [[ "$path" != "$module_name" ]]; then continue; fi
    #   if [[ -d "$parent_git/$path" ]]; then
    #     echo $module_name
    #     return 0;
    #   fi
    # done < <(cd $parent_git && git submodule --quiet foreach 'echo $path' 2> /dev/null)
  fi
  return 1
}


function parse_git_branch {
  P=

  # TODO(yesudeep): This bit is causing GDM on Ubuntu 12.04 to not login.
  # Disabled temporarily.
  # SM=
  # submodule=$(is_submodule)
  # if [[ $? -eq 0 ]]; then
  #   SM="s:$submodule"
  # fi
  # P=$P${SM:+${P:+ }${SM}}

  BRANCH=
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ $? -eq 0 ]]; then
    BRANCH="b:${ref#refs/heads/}"
  fi
  P=$P${BRANCH:+${P:+ }${BRANCH}}


  DESC="t:"$(git describe 2> /dev/null) || DESC=""
  P=$P${DESC:+${P:+ }${DESC}}

  # https://github.com/blog/297-dirty-git-state-in-your-prompt
  DIRTY=
  if [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]]; then
    DIRTY="*"
  fi

  echo "${DIRTY}git(${P}) "
}

# Determines whether the hg clone's working directory is dirty.
# :see:
#   http://stevelosh.com/blog/2009/03/mercurial-bash-prompts/
# :returns:
#   "*" if dirty.
function hg_dirty() {
  hg status --no-color 2> /dev/null \
    | awk '$1 == "?" { print "?" } $1 != "?" { print "*" }' \
    | sort | uniq | head -c1
}

# Parses mercurial status and displays it in the prompt.
# :returns:
#    Mercurial prompt status.
function parse_mercurial_branch {
  BRANCH=
  ref=$(hg branch 2> /dev/null) #| awk '{print "hg(b:" $1 ")"}'
  if [[ $? -eq 0 ]]; then
    BRANCH="b:${ref}"
  fi
  P=$P${BRANCH:+${P:+ }${BRANCH}}

  DIRTY=$(hg_dirty)

  echo "${DIRTY}hg(${P}) "
}

# Displays the git status in the prompt.
#
# :returns:
#    Status string.
function show_git_status {
  #STAT=$(git diff --stat 2> /dev/null) || STAT=""
  STAT=$(git status -s 2> /dev/null)
  if [[ $? -eq 0 ]]; then
    echo "$STAT"
  fi
}

# function parse_git_branch {
#   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
# }

# Displays the svn status in the prompt
#
# :returns:
#   Status string.
function parse_svn_revision {
  local DIRTY
  REV=$(svn info 2>/dev/null | grep Revision | sed -e 's/Revision: //')
  [ "$REV" ] || return
  [ "$(svn st)" ] && DIRTY='*'
  echo "${DIRTY}svn(r:${REV}) "
}

# Determines the revision control system in use and displays
# shell-contextual information based on that.
function parse_vc_branch {
  git show > /dev/null 2>&1 && parse_git_branch && return
  hg root > /dev/null 2>&1 && parse_mercurial_branch && return
  svn info > /dev/null 2>&1 && parse_svn_revision && return
}

function _proml {
  if [ $(id -u) -eq 0 ]
  then
    # Root user.
    local COLOR_FG_USR="${COLOR_FG_RED}"
    local DOLLAR=" bash\\#"
  else
    # Normal user.
    local COLOR_FG_USR="${COLOR_FG_GREEN}"
    local DOLLAR=" bash\\$"
  fi

  case $TERM in
    xterm*)
      TITLEBAR='\[\033]0;\u@\h:\w\007\]'
      ;;
    *)
      TITLEBAR=""
      ;;
  esac

  PS1="
${TITLEBAR}${COLOR_FG_GREEN}\d \@ [\t]${COLOR_RESET} ${COLOR_FG_RED}\u${COLOR_RESET}@${COLOR_FG_CYAN}\H${COLOR_RESET}
${COLOR_FG_BLUE}\w${COLOR_RESET}
${COLOR_FG_MAGENTA}\$(parse_vc_branch)${COLOR_RESET}${COLOR_FG_USR}${DOLLAR}${COLOR_RESET} "
  PS2='> '
  PS4='+ '
}
_proml


export PS1

#http://superuser.com/questions/204003/make-os-x-terminal-commands-i-type-bold
#off="\[\033[m\]"
#trap 'echo -ne "${off}" > $(tty)' DEBUG
