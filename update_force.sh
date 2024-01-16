#!/bin/bash
for d in */ ; do
    # If the directory begins with _, or does not contain a .git directory, skip it
    if [[ $d == _* ]] || [ ! -d "$d/.git" ]; then
        echo "Ignoring or skipping $d"
    else
        echo "Pulling $d"
        git -C "$d" clean -fd
        git -C "$d" checkout -- .
        git -C "$d" pull
    fi
done
read -p "Press enter to continue"