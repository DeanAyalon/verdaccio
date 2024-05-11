#!/bin/sh

check_env() {
    echo Checking environment
    # VERDACCIO_ENV is a container environment variable
    if [ -z $ENV_VERSION ] || [ -z $LATEST_ENV ] || [ $LATEST_ENV != $ENV_VERSION ]; then 
        echo Environment file not up to date! 
        exit 1
    fi
}

check_site() {
    echo Checking webserver

    req="curl -f https://$DOMAIN:$PROXY_PORT"

    echo "> $req"
    temp_file=$(mktemp)
    $req > "$temp_file" || exit 1

    echo Server is up and accessible
}

main() {
    echo Starting Verdaccio healthcheck
    check_env
    check_site
    echo "Container is healthy :)"
}

main