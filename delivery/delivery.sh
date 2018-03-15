#!/bin/bash

# fail on first error
set -e

set -a
source boot/build/libs/build.env
set +a

DOCKER_TAG=iglu/$PROJECT_NAME:$PROJECT_VERSION

build(){
    ./gradlew --no-daemon clean build

    cp boot/build/libs/boot.jar delivery/runner/boot.jar
    docker build -t $DOCKER_TAG delivery/runner
    rm delivery/runner/boot.jar
}

do_run(){
    build

    docker stop $PROJECT_NAME || true
    docker run --rm --publish=8080:8080 --name=$PROJECT_NAME $DOCKER_TAG $1
}

do_build(){
    build

    docker push $DOCKER_TAG
}

do_deploy(){
    ACTIVE_PROFILE=$1
    DEPLOY_SERVER=$2

    ssh ubuntu@$DEPLOY_SERVER sudo -s <<EOF
    docker pull $DOCKER_TAG
    docker stop $PROJECT_NAME
    docker run --rm --detach --publish=80:8080 --name=$PROJECT_NAME $DOCKER_TAG $ACTIVE_PROFILE
EOF
}


do_$1 $2 $3
