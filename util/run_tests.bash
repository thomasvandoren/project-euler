#!/usr/bin/env bash
#
# Args passed to this script are passed to start_test.

CWD=$(cd $(dirname $0) ; pwd)
TEST_DIR=$(cd ${CWD}/../test ; pwd)

start_time=$(date '+%s')
function elapsed_time()
{
    local end_time=$(date '+%s')
    local elapsed_time=$(($end_time - $start_time))
    local hours=$(($elapsed_time / 3600))
    local minutes=$(($elapsed_time / 60 % 60))
    local seconds=$(($elapsed_time % 60))
    echo "Elapsed time: ${hours} hours, ${minutes} minutes, ${seconds} seconds"
}
trap elapsed_time EXIT

echo "Copying chpl files to test/ dir."
cp $TEST_DIR/../*.chpl $TEST_DIR/

DIRS=$@
if [ -z "${DIRS}" ] ; then
    DIRS=$TEST_DIR
fi

echo "Running start_test with args: ${@}"
start_test --no-chpl-home-warn $DIRS

echo "Removing chpl files from test/ dir."
rm $CWD/*.chpl

echo 'Done!'
