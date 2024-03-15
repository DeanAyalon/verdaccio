help() {
    echo "Use: build-image.sh [-flag]"
    echo "  Flags:"
    echo "  -c(ache)    Build the image WITHOUT using cache                         Default: false"
    echo "  -p(rint)    Print execution"
    echo "  -v(ersion)  Specify version tag.                                        Default: latest"
    echo "  -h(elp)     Display this help dialog"
}

path=$(dirname $(dirname $(readlink -f $0))) # Verdaccio directory path

# Flags
version=latest        # Default version
while getopts "hcpv:" opt; do
    case $opt in
        h)  # Help
            help; exit 1 ;;
        c)  # No Cache
            no_cache=--no-cache ;;
        p)  # Penis
            penis=true ;;
        v)  # Version
            version=$OPTARG ;;
        \?) # undefined
            help; exit 1 ;;
    esac
done
shift $((OPTIND-1))
flags=$no_cache

# Build image
echo Building Verdaccio image
echo "Version: $version     Path: $path"
echo Flags: $no_cache
echo
echo "> docker build $flags -t dean-verdaccio:$version $path"
docker build $flags -t dean-verdaccio:$version $path



if [ $penis ]; then
    echo "          DOCKER IS RISING"
    echo "…………………...„„-~^^~„-„„_"
    echo "………………„-^*'' : : „'' : : : : *-„"
    echo "…………..„-* : : :„„--/ : : : : : : : '"
    echo "…………./ : : „-* . .| : : : : : : : : '|"
    echo "……….../ : „-* . . . | : : : : : : : : |"
    echo "………...\„-* . . . . .| : : : : : : : :'|"
    echo "……….../ . . . . . . '| : : : : : : : :|"
    echo "……..../ . . . . . . . .'\ : : : : : : : |"
    echo "……../ . . . . . . . . . .\ : : : : : : :|"
    echo "……./ . . . . . . . . . . . '\ : : : : : /"
    echo "….../ . . . . . . . . . . . . . *-„„„„-*'"
    echo "….'/ . . . . . . . . . . . . . . '|"
    echo "…/ . . . . . . . ./ . . . . . . .|"
    echo "../ . . . . . . . .'/ . . . . . . .'|"
    echo "./ . . . . . . . . / . . . . . . .'|"
    echo "'/ . . . . . . . . . . . . . . . .'|"
    echo "'| . . . . . \ . . . . . . . . . .|"
    echo "'| . . . . . . \„_^- „ . . . . .'|"
    echo "'| . . . . . . . . .'\ .\ ./ '/ . |"
    echo "| .\ . . . . . . . . . \ .'' / . '|"
    echo "| . . . . . . . . . . / .'/ . . .|"
    echo "| . . . . . . .| . . / ./ ./ . .|"
    echo "          DOCKER IS RISING"
fi
