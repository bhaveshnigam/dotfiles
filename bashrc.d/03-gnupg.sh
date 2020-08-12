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


# GNUPG configuration
# Script for ensuring only one instance of gpg-agent is running
# and if there is not one, start an instance of gpg-agent.
#if test -f $HOME/.gpg-agent-info && kill -0 `cut -d: -f 2 $HOME/.gpg-agent-info` 2>/dev/null; then
#	GPG_AGENT_INFO=`cat $HOME/.gpg-agent-info`
#	SSH_AUTH_SOCK=`cat $HOME/.ssh-auth-sock`
#	SSH_AGENT_PID=`cat $HOME/.ssh-agent-pid`
#	export GPG_AGENT_INFO SSH_AUTH_SOCK SSH_AGENT_PID
#else
#	eval `gpg-agent --daemon`
#	echo $GPG_AGENT_INFO >$HOME/.gpg-agent-info
#	echo $SSH_AUTH_SOCK > $HOME/.ssh-auth-sock
#	echo $SSH_AGENT_PID > $HOME/.ssh-agent-pid
#fi
# Imperative that this environment variable always reflects the output
# of the tty command.
#GPG_TTY=`tty`
#export GPG_TTY

# END GNUPG configuration
