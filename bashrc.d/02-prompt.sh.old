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


# Color names:
# base on http://pastie.org/154354
# color_name='\[\033[ color_code m\]'
rgb_restore='\[\033[00m\]'
rgb_black='\[\033[00;30m\]'
rgb_firebrick='\[\033[00;31m\]'
rgb_red='\[\033[01;31m\]'
rgb_forest='\[\033[00;32m\]'
rgb_green='\[\033[01;32m\]'
rgb_brown='\[\033[00;33m\]'
rgb_yellow='\[\033[01;33m\]'
rgb_navy='\[\033[00;34m\]'
rgb_blue='\[\033[01;34m\]'
rgb_purple='\[\033[00;35m\]'
rgb_magenta='\[\033[01;35m\]'
rgb_cadet='\[\033[00;36m\]'
rgb_cyan='\[\033[01;36m\]'
rgb_gray='\[\033[00;37m\]'
rgb_white='\[\033[01;37m\]'

rgb_std="${rgb_white}"

if [ `id -u` -eq 0 ]
then
    rgb_usr="${rgb_red}"
else
    rgb_usr="${rgb_forest}"
fi

# Different titlebar info depending on $TERM.
case $TERM in
    xterm*|rxvt*)
        TITLEBAR='\[\033]0;\u@\h \w\007\]'
        ;;
    emacs*)
        TITLEBAR=''
        ;;
    *)
        TITLEBAR="\u@\h \w"
        ;;
esac

# http://www.linuxselfhelp.com/howtos/Bash-Prompt/Bash-Prompt-HOWTO-2.html
# See the bash manpage.
# Different prompt depending on $TERM.
case $TERM in
    xterm*|rxvt*|emacs*)
        [ -n "$PS1" ] && PS1=\
"
${TITLEBAR}${rgb_forest}\d \@${rgb_restore} ${rgb_firebrick}\u${rgb_restore}@${rgb_cadet}\H
${rgb_firebrick}\w
${rgb_usr}\$${rgb_restore} "
        ;;

    *)
        [ -n "$PS1" ] && PS1="${TITLEBAR}\D{%Y-%m-%d} \t !\! \u@\h
\w
\$ "
        ;;
esac;

# Clean up
unset   rgb_restore   \
        rgb_black     \
        rgb_firebrick \
        rgb_red       \
        rgb_forest    \
        rgb_green     \
        rgb_brown     \
        rgb_yellow    \
        rgb_navy      \
        rgb_blue      \
        rgb_purple    \
        rgb_magenta   \
        rgb_cadet     \
        rgb_cyan      \
        rgb_gray      \
        rgb_white     \
        rgb_std       \
        rgb_usr

# From: https://wiki.archlinux.org/index.php/Color_Bash_Prompt
# Uncomment to enable.
#export PROMPT_COMMAND='history -a;echo -en "\n\n\033[m\033[38;5;2m"$(( `sed -nu "s/MemFree:[\t ]\+\([0-9]\+\) kB/\1/p" /proc/meminfo`/1024))"\033[38;5;22m/"$((`sed -nu "s/MemTotal:[\t ]\+\([0-9]\+\) kB/\1/Ip" /proc/meminfo`/1024 ))MB"\t\033[m\033[38;5;55m$(< /proc/loadavg)\033[m"'
#export PS1='\[\e[m\n\e[1;30m\][$$:$PPID \j:\!\[\e[1;30m\]]\[\e[0;36m\] \T \d \[\e[1;30m\][\[\e[1;34m\]\u@\H\[\e[1;30m\]:\[\e[0;37m\]${SSH_TTY} \[\e[0;32m\]+${SHLVL}\[\e[1;30m\]] \[\e[1;37m\]\w\[\e[0;37m\] \n\e[0;30m($SHLVL:\!)\n\w\$ '
#export PS1='\[\e[m\n\e[1;30m\][$$:$PPID \j:\!\[\e[1;30m\]]\n\[\e[0;36m\]\T \d \[\e[1;30m\][\[\e[1;34m\]\u@\H\[\e[1;30m\]:\[\e[0;37m\]${SSH_TTY} \[\e[0;32m\]+${SHLVL}\[\e[1;30m\]] \[\e[1;37m\]\w\[\e[0;37m\] \n\e[0;30m\w\$ '
