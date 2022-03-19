#!/usr/bin/env bash
# Run the service with the code for A2
set -o nounset
set -o errexit

function usage () {
  echo "Usage: ${0} [--detached] [MUSIC-DIR]"
  echo "Start Assignment 2 music service."
  echo
  echo "MUSIC-DIR is the directory containing 'music.csv'."
  echo "  Default: /home/ec2-user"
  echo
  echo "--detached: Run service container in detached mode."
}

if [[ $# -gt 2 ]]; then
  usage
  exit 1
elif [[ $# -eq 2 ]]; then
  if [[ "${1}"  == "--detached" && "${2:0:1}" != "-" ]]; then
    target=run-s2-detached
    home=${2}
  else
    usage
    exit 1
  fi
elif [[ $# -eq 1 ]]; then
  if [[ "${1}"  == "--detached" ]]; then
    target=run-s2-detached
    home=/home/ec2-user
  elif [[ "${1:0:1}" != "-" ]]; then
    target=run-s2
    home=${1}
  else
    usage
    exit 1
  fi
else
  target=run-s2
  home=/home/ec2-user
fi

make VER=v0.5 HOST_DIR=${home} ${target}
