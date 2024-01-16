#!/bin/bash

target_dir=$1
is_single_dir=0

if [ -z "$target_dir" ]; then
  target_dir="*"
else
  is_single_dir=1
fi

for dir in $target_dir; do
  dir=${dir%/}
  if [ $is_single_dir -eq 0 ]; then
    if [ "$dir" == "__pycache__" ]; then
      # echo "Ignoring $dir"
      :
    else
      check_dir "$dir"
    fi
  else
    check_dir "$dir"
  fi
done

read -p "Press enter to continue"

check_dir() {
  echo "checking $1 ..."
  if [ -d "$1/.git" ]; then
    git -C "$1" fetch > /dev/null
    behind=0
    while read -r line; do
      if [[ "$line" == *"Your branch is behind"* ]]; then
        commits=$(echo $line | cut -d ' ' -f 7)
        behind=1
      fi
    done < <(git -C "$1" status -uno)
    if [ $behind -eq 1 ]; then
      repo_url=$(git -C "$1" config --get remote.origin.url)
      repo_url=${repo_url/.git/}
      echo "... $commits commits behind."
      echo "$repo_url/compare/$(git -C "$1" rev-parse HEAD)...main"
    else
      echo "... No updates"
    fi
  else
    echo "... Skipping - No Git Repo found"
  fi
  cd ..
}
