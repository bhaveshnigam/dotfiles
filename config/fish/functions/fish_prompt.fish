# Matches our bash prompt configuration as closely as possible.

function _git_branch_name
  echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (git status -s --ignore-submodules=dirty ^/dev/null)
end

function fish_prompt --description 'Write out the prompt'
  set -l last_status $status

  # Colors.
  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l blue (set_color -o blue)
  set -l green (set_color -o green)
  set -l normal (set_color normal)

  set -g __fish_prompt_datetime (date)

  set -U fish_color_user cyan
  set -U fish_color_host green

  if not set -q __fish_prompt_hostname
    # set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    # Display the full hostname.
    set -g __fish_prompt_hostname (hostname)
  end

  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
  end

  set -l delimiter "fish>"
  set -l delim "$green$delimiter$__fish_prompt_normal"

  if [ (_git_branch_name) ]
    set -l git_branch $red(_git_branch_name)
    set -l _git_info "git:($git_branch$blue)"
    set git_info "$blue$_git_info"

    if [ (_is_git_dirty) ]
      set -l dirty "$yellow*"
      set git_info "$git_info$dirty$__fish_prompt_normal "
    else
      set git_info "$git_info$__fish_prompt_normal "
    end
  end

  switch $USER
    case root
      if not set -q __fish_prompt_cwd
        if set -q fish_color_cwd_root
          set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
        else
          set -g __fish_prompt_cwd (set_color $fish_color_cwd)
        end
      end

    case '*'
      if not set -q __fish_prompt_cwd
        set -g __fish_prompt_cwd (set_color $fish_color_cwd)
      end
  end

  set -l prompt_status
  if test $last_status -ne 0
    if not set -q __fish_prompt_status
      set -g __fish_prompt_status (set_color $fish_color_status)
    end
    set prompt_status "$__fish_prompt_status [$last_status]$__fish_prompt_normal"
  end

  if not set -q __fish_prompt_user
    set -g __fish_prompt_user (set_color $fish_color_user)
  end
  if not set -q __fish_prompt_host
    set -g __fish_prompt_host (set_color $fish_color_host)
  end

  #echo -s ''
  echo -s "$__fish_prompt_datetime $__fish_prompt_user" "$USER" "$__fish_prompt_normal" @ "$__fish_prompt_host" "$__fish_prompt_hostname" "$__fish_prompt_normal"
  echo -s "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal"
  echo -s $git_info "$prompt_status" "$delim" ' '
end
