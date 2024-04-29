#!/bin/bash

# Absolute path (Keeping execution syntax for mount paths)
repo=$(cd "$(dirname "$0")"; pwd)

# Environment
"$repo/env.sh" || exit 1
source $repo/.env

# Image
if [ -z $REPO ]; then 
    image=$IMAGE
    tag=$VERSION
else
    image=$REPO
    tag=$IMAGE-$VERSION
fi

# Default values
port=4873

# Help dialog
function help() {
    echo Use: $0 [flags]
    echo Flags:
    echo "  -d      Take container down"
    echo "  -h      Show this help dialog"
    echo "  -p      Specify Port            Default: $port"
}

# Flags
while getopts "dhp:" opt; do
    case ${opt} in
        # Down
        d ) docker compose down ; exit 0 ;;

        # Help
        h ) help ; exit 2 ;;

        # Port
        p ) port=$OPTARG ;;

        # Undefined
        * ) help ; exit 1 ;;
    esac
done
shift $((OPTIND -1))

# Execution context
cd $repo

# Create docker-compose
echo "name: $PROJECT
services:
  verdaccio:
    build:
      context: $repo
      dockerfile: dockerfile
    image: $image:$tag
    container_name: $CONTAINER
    ports:
      - "$port:4873"
    volumes:
      - $MOUNT/storage:/verdaccio/storage
      - $MOUNT/certs:/verdaccio/certs" > docker-compose.yml

docker compose up -d