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


# Number of commands that the history keeps track of.
HISTSIZE=10000

# Indefinitely growing history file.
HISTFILESIZE=''

# Don't cache consecutive duplicates.
HISTCONTROL=ignoreboth

# Display the history like this:
#
# username@host$ history | tail -n 5
# 245  Fri, 20 Jul 2007 12:39:26PM -0500 history
# 246  Fri, 20 Jul 2007 12:39:52PM -0500 history | tail
# 247  Fri, 20 Jul 2007 12:40:03PM -0500 nano .bash_profile
# 248  Fri, 20 Jul 2007 12:41:56PM -0500 exit
# 249  Fri, 20 Jul 2007 12:42:06PM -0500 history | tail -n 5
HISTTIMEFORMAT='%a, %d %b %Y %l:%M:%S%p %z '
