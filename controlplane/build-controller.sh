#!/bin/bash
set -x

SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
MAKEDIR=$SCRIPTDIR/../../controller/

make -C $MAKEDIR build
STATUS=$?
if [ $STATUS -ne 0 ]; then
    echo -e "\n***********\nFAILED: make failed for controller.\n***********\n"
    exit $STATUS
fi

make -C $MAKEDIR docker IMAGE_NAME=controller-0.1
STATUS=$?
if [ $STATUS -ne 0 ]; then
    echo -e "\n***********\nFAILED: docker build failed for controller.\n***********\n"
    exit $STATUS
fi