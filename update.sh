#!/bin/bash
for i in */; do
    # Remove trailing slash
    dir_name=${i%/}
    # If the directory begins with _, skip it
    if [[ ${dir_name:0:1} == "_" ]]; then
        echo "Ignoring $dir_name"
    elif [[ ! -d "$i/.git" ]]; then
        # If the directory does not contain a .git directory, skip it
        echo "Skipping $dir_name - No repository found"
    else
        echo "Pulling $dir_name"
        git -C "$i" pull
    fi
done
read -p "Press enter to continue"