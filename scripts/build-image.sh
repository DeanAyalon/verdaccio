#!/bin/bash
# WARN - Run from the context of the verdaccio repository's root directory!

NO_CACHE=$1

# docker build -t certs . -f dockerfile.certs
if [ "$NO_CACHE" = "1" ]; then
    docker build --no-cache -t dean-verdaccio .
else
    docker build -t dean-verdaccio .
fi
