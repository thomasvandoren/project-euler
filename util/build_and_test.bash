#!/usr/bin/env bash
#
# Download and build chapel, then run tests.

CWD=$(cd $(dirname $0) ; pwd)
source $CWD/common.bash

CHPL_GIT_URL=${CHPL_GIT_URL:-git://github.com/chapel-lang/chapel.git}
CHPL_GIT_BRANCH=${CHPL_GIT_BRANCH:-master}
export CHPL_HOME=$REPO_ROOT/chapel-src

log_info "Cloning chapel repo (branch: ${CHPL_GIT_BRANCH} url: ${CHPL_GIT_URL})"
git clone --branch $CHPL_GIT_BRANCH $CHPL_GIT_URL $CHPL_HOME

log_info "Moving to CHPL_HOME (${CHPL_HOME}) and building chapel..."
cd $CHPL_HOME
source util/setchplenv.bash && make -j

log_info "Running make all-tests"
make -C $REPO_ROOT all-tests
