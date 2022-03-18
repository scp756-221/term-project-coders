#!/usr/bin/env bash
# Quicky generate ${1} of 1K blocks of random bytes
set -o nounset
set -o errexit
if [[ $# -ne 1 ]]; then
  echo "Usage: ${0} N"
  echo "Create a file 'random.bytes' with N 1K blocks of random data."
  echo
  echo "  N is the number of 1K blocks to create."
  exit 1
fi
# See 
# https://superuser.com/questions/792427/creating-a-large-file-of-random-bytes-quickly
# for an explanation of this command.
# The second 2>/dev/null is added because openssl complains that one
# parameter is now insecure but we ignore that because our use case doesn't
# need secure encryption.
dd if=<(openssl enc -aes-256-ctr \
        -pass pass:"$(dd if=/dev/urandom bs=64 count=1 2>/dev/null | base64)" \
        -nosalt \
        < /dev/zero 2> /dev/null) \
  of=random.bytes bs=1K count=${1} iflag=fullblock