#!/bin/bash

# fail on first error
set -e

set -a
source boot/build/libs/build.env
set +a

DOCKER_TAG=iglu/$PROJECT_NAME:$PROJECT_VERSION

do_devel(){
    ./gradlew --no-daemon clean build

    cp boot/build/libs/boot.jar delivery/runner/boot.jar
    docker build -t $DOCKER_TAG delivery/runner
    rm delivery/runner/boot.jar

    docker stop $PROJECT_NAME || true
    docker run --rm --publish=8080:8080 --name=$PROJECT_NAME $DOCKER_TAG $1
}

do_$1 $2
