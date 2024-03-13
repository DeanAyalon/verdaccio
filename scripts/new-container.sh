#!/bin/bash 

# Flags
help() {
    echo Use: new-container.sh [-flags] [container name]
    echo "  Flags:"
    echo "  -p(ort)     Specify host port to map to Verdaccio.  Default: 4873"
    echo "  -v(ersion)  Specify version tag.                    Default: latest"
    echo "  -h(elp)     Display this help dialog"
}

version="latest" # Default version
port=4873
while getopts "hp:v:" opt; do
    case $opt in
        h)
            help; exit 1 ;;
        p)
            port=$OPTARG ;;
        v)
            version=$OPTARG ;;
        \?) 
            help; exit 1 ;;
    esac
done
shift $((OPTIND-1))


IMAGE=dean-verdaccio
name=$1

if [ -z $name ]; then
    name=$IMAGE
fi

echo Running new Docker Container $name using Image $IMAGE
echo "Port: $port   Version: $version"
echo
echo "> docker run -dit --name=$name -p $port:4873 $IMAGE:$version"
docker run -dit --name=$name -p $port:4873 $IMAGE:$version
