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
exitcode=0
important=("@dean" "@helper")
echo Backing up important directories
for dir in "${important[@]}"; do
    echo "Backing up $dir"
    mkdir -p "$backup/$dir"
    cp -r "$data/$dir" -t "$backup/$dir" || exitcode=1      # Copy failed, continue trying to backup all directories before exit 1
done

# Backup specified directories
[ -z $1 ] && exit $exitcode                                 # No more packages to backup

echo "Backing up specified directories"
for dir in "$@"; do
    if [ -d "$data/$dir" ]; then
        if cp -r "$data/$dir" -t "$backup"; then
            echo "Backed up $dir"
        else
            exitcode=1                                      # Copy failed, continue trying to backup all directories before exit 1
        fi
    else
        echo "Directory $dir does not exist"
        exitcode=1                                          # Dir not found, continue trying to backup all directories before exit 1
    fi
done
exit $exitcode
