#!/usr/bin/env bash
# Run the service with the code for A3
# Note: do not use this in the actual A3.
# That assignment requests students to use the
# actual docker calls to run the container.
#
# This script is used in ci-a3.yml.
set -o nounset
set -o errexit

if [[ $# -gt 1  || $# == 1 && "${1}"  != "--detached" ]]
then
  echo "Usage: ${0} [--detached]"
  exit 1
fi

if [[ $# -eq 1 ]]
then
  target=run-s2-detached
else
  target=run-s2
fi

make VER=v0.75 HWD=${HWD} ${target}
