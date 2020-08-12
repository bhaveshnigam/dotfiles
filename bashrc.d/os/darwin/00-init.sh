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

# Update environment.plist at every startup.
# The following produces gibberish.
# if [ -x /usr/libexec/path_helper ]; then
#   eval `/usr/libexec/path_helper -s`
#   defaults write $HOME/.MacOSX/environment PATH "$PATH"
# fi

# Fix for Emacs.app not reading the shell environment variable $PATH
# so we keep $PATH in sync with the launchd process which is used to
# start applications using Spotlight on Mac OS X.
#
# For more information, see: http://emacswiki.org/emacs/EmacsApp
#
# This requires the entire path environment to have been loaded before
# we call this. Ensure the order of loading shell scripts in
# ~/.dotfiles/bachrc is correct if this doesn't work. That is,
# ~/.path_environment should be sourced before anything else.
# launchctl setenv PATH $PATH

# Now we need a way to keep the launchd path in sync with
# shell $PATH system-wide. Something to edit /etc/launchd.conf
# % cat /etc/launchd.conf
## include macports in global path - basically so Emacs.app can see git
#setenv PATH /opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin
# May be a python script that keeps updating PATH in launchd.conf?
