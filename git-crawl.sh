#!/bin/sh

function git-climb() {
  local -r pos="${1}"
  local up_to="${2}"

  if [ -z "${branch}" ]; then
    up_to="master"
  fi

  if [ "${pos}" = "start" ]; then
    git checkout $(git rev-list --reverse HEAD | head -1)
    return 0;
  fi

  if [ "${pos}" = "next" ]; then
    local -r root=$(git rev-list --reverse HEAD | tail -1)
    git checkout $(git rev-list --reverse --ancestry-path "${root}".."${up_to}" | head -1)
    return 0;
  fi

  >&2 echo "Examples:"
  >&2 echo "  git-start start"
  >&2 echo "  git-start next [sha or branch-name]"
  return 1;
}
