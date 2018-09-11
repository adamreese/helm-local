#!/bin/bash
set -euo pipefail

(("${TRACE-}")) && set -x

: "${TILLER_ADDR:=:44134}"
: "${TILLER_ARGS:=}"
: "${TILLER_BIN:=$(which tiller)}"
: "${TILLER_LOG:=/tmp/tiller.log}"

usage() {
cat << EOF
Run Tiller as a local daemon.

  $ helm local start
  $ helm local [command]

You can setup environment variables to run helm commands directly.

  $ source <(helm local env)
  $ helm list

Usage:
  helm local [command]

Environment:
  TILLER_ADDR   address:port to listen on (default ":44134")
  TILLER_ARGS   extra args to pass to Tiller
  TILLER_BIN    Tiller binary to use
  TILLER_LOG    log to file (default: "/tmp/tiller.log")

Available Commands:
  env           setup environment variables
  kill          kill running instance of Tiller
  start         start a local Tiller instance
  status        get status of running Tiller

EOF
}

tiller::start() {
  ${TILLER_BIN} -listen ${TILLER_ADDR} -alsologtostderr "${TILLER_ARGS}" >"${TILLER_LOG}" 2>&1 &
}

tiller::running() {
  pgrep -f "${TILLER_BIN}"
}

tiller::kill() {
  pkill -f "${TILLER_BIN}"
}

tiller::status() {
  tiller::running || {
    echo >&2 "Tiller is not running"
    exit 1
  }
  echo "Tiller is listening on ${TILLER_ADDR}"
}

helm::run() {
  tiller::running || tiller::start

  helm --host "${TILLER_ADDR}" "$@"
}

helm::env() {
cat << EOF
export HELM_HOST="${TILLER_ADDR}"
EOF
}

case "${1}" in
  help|--help|-h)
    usage
    ;;
  kill|stop)
    tiller::kill
    ;;
  start)
    tiller::start
    ;;
  status)
    tiller::status
    ;;
  env)
    helm::env
    ;;
  *)
    helm::run "$@"
    ;;
esac
