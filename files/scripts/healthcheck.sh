#!/bin/sh

req="curl -f https://deanayalon.com:4873"

echo "> $req"
temp_file=$(mktemp)
$req > "$temp_file" || exit 1

echo Server is up, checking src
# cat $temp_file
host_err=$(grep "localhost" "$temp_file")
rm $temp_file

if [ ! -z "$host_err" ]; then
    echo "Script src incorrectly set to localhost"
    exit 1
else
    echo "Container is healthy"
fi
