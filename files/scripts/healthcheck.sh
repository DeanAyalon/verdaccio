#!/bin/sh

check_env() {
    echo Checking environment
    # VERDACCIO_ENV is a container environment variable
    ([ -z $VERDACCIO_ENV ] || [ -z $LATEST_ENV ] || [ $LATEST_ENV != $VERDACCIO_ENV ]) && exit 1
}

check_site() {
    echo Checking webserver

    req="curl -f https://$DOMAIN:$PROXY_PORT"

    echo "> $req"
    temp_file=$(mktemp)
    $req > "$temp_file" || exit 1

    echo Server is up, checking src
    echo This check needs updating....

    # TODO: IMPLEMENT BETTER CHECKING, AND MAKE SURE THE CORRECT URL IS IN SCRIPTS
    # host_err=$(grep "localhost" "$temp_file")
    # rm $temp_file

    # if [ ! -z "$host_err" ]; then
    #     echo "Script src incorrectly set to localhost"
    #     exit 1
    # else
    #     echo "Site is responsive"
    #     exit 0
    # fi
}

main() {
    echo Starting Verdaccio healthcheck
    check_env
    check_site
}

main