#!/bin/bash

exec_devel(){
    export SPRING_PROFILES_ACTIVE=devel
    exec java -jar boot.jar
}

exec_test(){
    export SPRING_PROFILES_ACTIVE=test
    exec java -jar boot.jar
}

exec_live(){
    export SPRING_PROFILES_ACTIVE=live
    exec java -jar boot.jar
}

exec_$1
