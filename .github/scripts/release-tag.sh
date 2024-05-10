# Get git ref from ${{ github.event.ref }}
ref=$1      # refs/heads/BRANCH

# Get branch name from ref
branch=$(echo "$ref" | awk -F'heads/' '{print $2}')
echo Branch: $branch

# Determine release tag
case $branch in
    main )      tag=stable ;;
    dev )       tag=latest ;;
    release/* ) tag=$(echo "$branch" | awk -F'release/' '{print $2}') ;;
    * ) echo Not a release branch ; exit 1 ;;
esac

echo Tag: $tag
echo "TAG=$tag" >> $GITHUB_OUTPUT