#!/usr/bin/env bash
#
# Common utilities.

CWD=$(cd $(dirname ${BASH_SOURCE[0]}) ; pwd)
REPO_ROOT=$(cd $CWD/.. ; pwd)

function log_date()
{
    echo -n "$(date '+%Y-%m-%d %H:%M:%S') "
}

function log_info()
{
    local msg=$@
    log_date
    echo "[INFO] ${msg}"
}

function log_debug()
{
    log_info $@
}

function log_error()
{
    local msg=$@
    log_date
    echo "[ERROR] ${msg}"
}
