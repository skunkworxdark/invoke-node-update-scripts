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
    if [[ "$dir" > "_" && "$dir" < "_z" ]]; then
      echo "Ignoring $dir"
    else
      check_dir "$dir"
    fi
  else
    check_dir "$dir"
  fi
done

read -p "Press enter to continue"

function check_dir {
  if [ -d "$1/.git" ]; then
    echo "Pulling $1"
    git -C "$1" pull
  else
    echo "Skipping $1 - No Git Repo found"
  fi
}
