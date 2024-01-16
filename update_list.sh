#!/bin/bash
echo "The following directories have updates to download:" > updates.txt
for d in */ ; do
  if [ "$d" == "__pycache__/" ]; then
    continue
  fi
  cd "$d"
  if [ -d .git ]; then
    echo "checking... $d"
    git fetch > /dev/null
    behind=0
    while read -r s; do
      if [[ $s == *"Your branch is behind"* ]]; then
        commits=$(echo $s | cut -d' ' -f7)
        behind=1
      fi
    done < <(git status -uno)
    if [ $behind -eq 1 ]; then
      repo_url=$(git config --get remote.origin.url)
      repo_url=${repo_url/https:\/\/github.com\//https:\/\/github.com/}
      repo_url=${repo_url/.git/}
      commit_hash=$(git rev-parse HEAD)
      echo "$d is $commits commits behind." >> ../updates.txt
      echo "$repo_url/compare/$commit_hash...main" >> ../updates.txt
    fi
  else
    echo "$d is not a git repository"
  fi
  cd ..
done
cat updates.txt