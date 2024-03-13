#!/bin/sh

# Get script path
scripts=$(dirname $(readlink -f $0))    # Scripts directory
storage=$(dirname "$scripts")/storage   # Verdaccio storage path    $scripts/../storage


# Relative paths
backup="$storage/backup"
data="$storage/data"

# # Backup, or exit if fails

sh "$scripts/bu.sh" $@ || exit 1

# # Remove registry packages
echo Clearing packages
rm -rf "$data"
# # Restore from backup
mv "$backup" "$data"
