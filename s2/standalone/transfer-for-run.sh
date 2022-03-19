#!/usr/bin/env bash
# Transfer (much smaller) list of files required for A3
set -o nounset
set -o errexit

if [[ $# -ne 3 ]]
then
  echo "Usage: ${0} PEM-PATH USERID INSTANCE"
  echo "  PEM-PATH is the relative path to the '.pem' file containing the key"
  echo "  USERID is the userid for signing on to the remote instance (typically either 'ubuntu' or 'ec2-user')"
  echo "  INSTANCE is the name of the remote instance"
  exit 1
fi

pem=${1}
userid=${2}
instance=${3}

set -o xtrace
scp -i ${pem} music.csv                       ${userid}@${instance}:/home/${userid}/
scp -i ${pem} ../../cluster/ghcr.io-token.txt ${userid}@${instance}:/home/${userid}/
