#!/bin/bash

# Flags
help() {
    echo "Use: build-image.sh [-flag]"
    echo "  Flags:"
    echo "  -c(ache)    Build the image WITHOUT using cache                         Default: false"
    echo "  -p(ath)     Specify path to the directory containing the dockerfile.    Default: ."
    echo "  -v(ersion)  Specify version tag.                                        Default: latest"
    echo "  -h(elp)     Display this help dialog"
}
version="latest" # Default version
path="."
while getopts "hcv:" opt; do
    case $opt in
        h)
            help; exit 1 ;;
        c)
            no_cache=--no-cache ;;
        p)  
            path=$OPTARG ;;
        v)
            version=$OPTARG ;;
        \?) 
            help; exit 1 ;;
    esac
done
shift $((OPTIND-1))
flags=$no_cache

# docker build $no_cache -t certs . -f dockerfile.certs
docker build $flags -t dean-verdaccio:$version $path