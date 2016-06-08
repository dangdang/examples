#!/bin/bash
set -x

SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
MAKEDIR=$SCRIPTDIR/../../sidecar/

make -C $MAKEDIR build
STATUS=$?
if [ $STATUS -ne 0 ]; then
    echo -e "\n***********\nFAILED: make failed for sidecar.\n***********\n"
    exit $STATUS
fi

make -C $MAKEDIR docker IMAGE_NAME=kube-sidecar-reg:0.1 DOCKERFILE=./docker/Dockerfile.kube.reg
STATUS=$?
if [ $STATUS -ne 0 ]; then
    echo -e "\n***********\nFAILED: docker build failed for sidecar register.\n***********\n"
    exit $STATUS
fi

make -C $MAKEDIR docker IMAGE_NAME=kube-sidecar-proxy:0.1 DOCKERFILE=./docker/Dockerfile.kube.proxy
STATUS=$?
if [ $STATUS -ne 0 ]; then
    echo -e "\n***********\nFAILED: docker build failed for sidecar proxy.\n***********\n"
    exit $STATUS
fi