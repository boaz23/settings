#!/usr/bin/sh

# This script adds SSH keys.
# It can be source at shell initialization "rc" (`~/.bashrc` or
# some similar file) to automatically add the SSH keys on start

if [ "$1" = "" ]; then
  echo "Cannot add git SSH key because no environment name was given" >&2
else
    env=~/.ssh/envs/$1
    keys=(
        ~/.ssh/keys/github
    )

    agent_load_env() {
        test -f "$env" && . "$env" >| /dev/null
    }

    agent_start() {
        (umask 077; ssh-agent > "$env") && . "$env" >| /dev/null
    }

    add_ssh_keys() {
        ssh-add -t 43200 -- "${keys[@]}"
    }

    agent_load_env

    agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)
    # 0: running with key
    # 1: running without key
    # 2: not running

    if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
        agent_start && add_ssh_keys
    elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
        add_ssh_keys
    fi

    unset env
fi
