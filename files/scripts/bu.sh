#!/bin/sh

# Get scripts path
storage=$(dirname $(dirname $(readlink -f $0)))/storage   # Verdaccio storage path

# Relative paths
backup="$storage/backup"
data="$storage/data"

# Backup @dean packages
echo "Backing up @dean"
mkdir -p "$backup"
cp -r "$data/@dean" -t "$backup"

# Backup specified directories
[ -z $1 ] && exit 0                         # 0 is a successful exit code - No more packages to backup

echo "Backing up specified directories"
for dir in "$@"; do
    if [ -d "$data/$dir" ]; then
        cp -r "$data/$dir" -t "$backup"
        echo "Backed up $dir"
    else
        echo "Directory $dir does not exist"
        flag=true   # Flagging so all other packages are backed up before script fails
    fi
done

[ -z $flag ] || exit 1 # Fail if a directory was not found, so the clear script does not execute