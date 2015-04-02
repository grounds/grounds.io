#!/bin/sh

set -e

repository="$1"

if [ $TAG ]; then
    tag="$TAG"
else
    tag="latest"
fi

runner_images() {
    echo $(docker search $repository | grep "$repository/exec-" | awk -F ' ' '{ print $1 }')
}

if [ -z $repository ]; then
    echo "usage: pull REPOSITORY TAG"
    return
fi

for image in $(runner_images); do
    docker pull "$image:$tag"
done
