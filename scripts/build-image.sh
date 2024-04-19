help() {
    echo "Use: build-image.sh [-flag]"
    echo "  Flags:"
    echo "  -c(ache)    Build the image WITHOUT using cache                         Default: false"
    echo "  -p(rint)    Print execution"
    echo "  -v(ersion)  Specify version tag.                                        Default: latest"
    echo "  -h(elp)     Display this help dialog"
}

# Execution context - repo
cd "$(dirname "$0")/.."

# Flags
version=latest        # Default version
while getopts "hcpv:" opt; do
    case $opt in
        # Help
        h)  help; exit 2 ;;

        # No Cache
        c)  no_cache=--no-cache ;;

        # Penis
        p)  penis=true ;;
        
        # Version
        v)  version=$OPTARG ;;

        # undefined
        \?) help; exit 1 ;;
    esac
done
shift $((OPTIND-1))
flags=$no_cache

# Build image
echo Building Verdaccio image
echo "Version: $version     Path: $repo"
echo Flags: $no_cache
echo
echo "> docker build $flags -t dean-verdaccio:$version $repo"
docker build $flags -t dean-verdaccio:$version $repo

# Eran left me a little surprise
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
