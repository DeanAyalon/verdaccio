#!/bin/bash 

scripts=$(dirname $(readlink -f $0))

IMAGE=dean-verdaccio

# Defaults
mounts=~/Documents/verdaccio
port=4873
version=latest
# Help
help() {
    echo Use: new-container.sh [-flags] [container name]
    echo "  Default container name: dean-verdaccio"
    echo "  Flags:"
    echo "  -m(ounts)   Specify path to mount a volume for persistant storage                               Default: $mount"
    echo "              The mounted directory should contain a certs folder with SSL certificate files:"
    echo "                  privkey.pem and fullchain.pem"
    echo "              Free trusted certificates from Let's Encrypt can be created using the certificates repo"
    # echo "              Use '!path' to avoid mounting a volume, instead specify a path for the certificate"
    echo "  -p(ort)     Specify host port to map to Verdaccio.                                              Default: $port"
    echo "  -v(ersion)  Specify version tag.                                                                Default: $version"
    echo "  -h(elp)     Display this help dialog"
}
# Flags
while getopts "hm:p:v:" opt; do
    case $opt in
        h)
            help; exit 1 ;;
        m)
            mounts="$OPTARG" ;;
        p)
            port=$OPTARG ;;
        v)
            version=$OPTARG ;;
        \?) 
            help; exit 1 ;;
    esac
done
shift $((OPTIND-1))

if [ "$mounts" = "!" ]; then 
    mountcmd=""
else
    mountcmd="-v $mounts/storage:/verdaccio/storage -v $mounts/certs:/verdaccio/certs"
fi


name=$1
[ -z $name ] && name=$IMAGE

cmd="docker run -dit --name=$name -p $port:4873 $mountcmd $IMAGE:$version"

echo Running new Docker Container $name using Image $IMAGE
echo "Port: $port   Version: $version"
[ -z "$mountcmd" ] || echo "Mount: $mount"
echo
echo "> $cmd"
$cmd
