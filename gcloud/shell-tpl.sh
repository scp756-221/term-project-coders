#!/usr/bin/env bash
# Start the CMPT 756 environment
# With `gcloud` added
set -o nounset
set -o errexit
set -o xtrace
if [[ $# -eq 1 ]]
then
  VER=${1}
else
  # Let registry select the appropriate architecture
  VER=latest
fi
CREG=${CREG:-ZZ-CR-ID}
REGID=${REGID:-ZZ-REG-ID}
INAME=${INAME:-gcloud}
TZ=${TZ:-Canada/Pacific}
docker container run -it --rm \
  -v ${HOME}/.aws:/root/.aws \
  -v ${HOME}/.azure:/root/.azure \
  -v ${HOME}/.minikube:/root/.minikube \
  -v ${HOME}/.ssh:/root/.ssh \
  -v ${HOME}/.kube:/root/.kube \
  -v ${HOME}/.config:/root/.config \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ${PWD}/gatling/results:/opt/gatling/results \
  -v ${PWD}/gatling:/opt/gatling/user-files \
  -v ${PWD}/gatling/target:/opt/gatling/target \
  -v ${PWD}:/home/k8s \
  -e TZ=${TZ} \
  -e HWD=${PWD} \
  ${CREG}/${REGID}/${INAME}:${VER}
