#!/bin/sh

# Verdaccio storage path
storage=$(dirname $(dirname $(readlink -f $0)))/storage

# /verdaccio
    # /scripts/bu,sh
    # /storage
        # /backup
        # /data

# Relative paths
backup="$storage/backup"
data="$storage/data"

# Backup important directories
important=("@dean" "@helper")
echo Backing up important directories
for dir in "${important[@]}"; do
    echo "Backing up $dir"
    mkdir -p "$backup/$dir"
    cp -r "$data/$dir" -t "$backup/$dir"
done

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