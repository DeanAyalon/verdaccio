#!/bin/bash 

NAME=$1
# PORT=$2

IMAGE=dean-verdaccio

if [ -z $NAME ]; then
    NAME=$IMAGE
fi
# if [ -z $PORT ]; then
#     PORT=4873
# fi

docker run -dit --name=$NAME -p 4873:4873 $IMAGE
# docker run -dit --name=$NAME -p $PORT:4873 $IMAGE
