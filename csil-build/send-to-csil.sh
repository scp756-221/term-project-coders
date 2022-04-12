#!/usr/bin/env bash
# Send the prerequisite files for running on a CSIL server
set -o errexit
set -o nounset
if [[ $# -ne 2 ]]
then
  echo "Usage: send-to-csil.sh USER MACHINE"
  echo "  USER: An SFU userid"
  echo "  MACHINE: The name of a CSIL machine"
  exit 1
fi
user=${1}
machine=${2}
set -o xtrace
scp -P 24 ../cluster/tpl-vars.txt      ${user}@${machine}:/home/${user}/c756-exer/e-k8s/cluster
scp -P 24 ../cluster/ghcr.io-token.txt ${user}@${machine}:/home/${user}/c756-exer/e-k8s/cluster
scp -P 24 cleanup-csil-756.sh          ${user}@${machine}:/home/${user}
