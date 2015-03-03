#!/bin/sh

function git-climb() {
  local -r pos="${1}"
  local branch="${2}"

  if [ -z "${branch}" ]; then
    branch="master"
  fi

  if [ "${pos}" = "start" ]; then
    git checkout $(git rev-list --reverse HEAD | head -1)
    return 0;
  fi

  if [ "${pos}" = "next" ]; then
    local -r root=$(git rev-list --reverse HEAD | tail -1)
    git checkout $(git rev-list --reverse --ancestry-path "${root}".."${branch}" | head -1)
    return 0;
  fi

  >&2 echo "git-start [start|next]"
  return 1;
}
