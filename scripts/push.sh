#!/bin/sh

set -e

repository="$1"
tag="$2"
image="$repository/grounds.io:$tag"

if [ -z $repository ]; then
    echo "usage: push REPOSITORY TAG"
    return
fi

docker tag groundsio_web $image
docker push $image
