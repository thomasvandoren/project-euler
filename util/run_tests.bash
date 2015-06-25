#!/usr/bin/env bash
#
# Args passed to this script are passed to start_test.

CWD=$(cd $(dirname $0) ; pwd)
source $CWD/common.bash

TEST_DIR=$(cd ${CWD}/../test ; pwd)
START_TEST_LOG=${REPO_ROOT}/chpl_test.log

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

log_info "Copying chpl files to test/ dir."
cp $TEST_DIR/../*.chpl $TEST_DIR/

DIRS=$@
if [ -z "${DIRS}" ] ; then
    DIRS=$TEST_DIR
fi

log_info "Running start_test with args: ${DIRS}"
start_test --no-chpl-home-warn --logfile $START_TEST_LOG $DIRS

log_info "Removing chpl files from test/ dir."
rm $CWD/*.chpl

test_output_log=$START_TEST_LOG

# The following is mostly a wholesale copy of:
# https://github.com/chapel-lang/chapel/blob/master/util/test/checkChplInstall

# Vars for capturing status info.
success_key="^\[Success matching"
error_key="^\[Error"
warning_key="^\[Warning"
summary_key="^\[Summary"
summary_start_key="^\[Test Summary"

function find_test_lines()
{
    local key="${1}"
    local count_arg="${2}"

    # Find the "[Start Summary ...]" line, then grep for $key after it. 100000
    # is an arbitrarily large number that should include the rest of the file
    # after [Start Summary ...].
    grep -A100000 -E "${summary_start_key}" $test_output_log | \
        grep $count_arg -E "${key}"
}

successes=$(grep -c -E "${success_key}" $test_output_log)
errors=$(find_test_lines "${error_key}" -c)
warnings=$(find_test_lines "${warning_key}" -c)

log_debug "successes: ${successes}"
log_debug "errors: ${errors}"
log_debug "warnings: ${warnings}"

# First, check for errors and warnings. Then make sure there was at least one success.
if (( $errors )) && (( $errors > 0 )) ; then
    log_error "${errors} tests failed:"
    find_test_lines "${error_key}"
    success=false
elif (( $warnings )) && (( $warnings > 0 )) ; then
    log_error "${warnings} tests produced warnings:"
    find_test_lines "${warning_key}"
    success=false
elif (( $successes < 1 )) ; then
    log_error "No tests ran."
    success=false
else
    success=true
fi

# Print out the summary line.
log_debug $(grep -E "${summary_key}" $test_output_log)

case $success in
    true)
        log_info 'All tests pass!'
        exit 0
        ;;
    false|*)
        log_info "Found test failures. Exiting with non-zero code."
        exit 1
        ;;
esac
