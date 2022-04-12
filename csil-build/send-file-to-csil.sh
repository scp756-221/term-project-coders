#!/usr/bin/env bash
# Send a service source file to a CSIL server
set -o errexit
set -o nounset
if [[ $# -ne 3 ]]
then
  echo "Usage: send-file-to-csil.sh USER MACHINE PATH"
  echo "  USER: An SFU userid"
  echo "  MACHINE: The name of a CSIL machine"
  echo "  PATH: The path to a file, relative to 'e-k8s'. Example: 's1/app.py'"
  exit 1
fi
user=${1}
machine=${2}
path=${3}
set -o xtrace
scp -P 24 ${path} ${user}@${machine}:/home/${user}/c756-exer/e-k8s/${path}
