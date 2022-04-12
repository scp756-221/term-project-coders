#!/usr/bin/env bash
# Remove the entire CMPT 756 directory from a CSIL home directory
# ** This will only run on a machine whose host name matches "csil.*\.sfu\.ca"
#
# Set" strict mode" options (see https://devhints.io/bash)
set -o nounset
set -o errexit
set -o pipefail
IFS=$'\n\t'

# The directory we will ultimately delete
c756dir='c756-exer'

# CHECK 1: Are we on a CSIL machine?
host=$(hostname -f)
if [[ "${host:0:4}" != "csil" || "${host:(-7):7}" != ".sfu.ca" ]]
then
  echo "The hostname '${host}' does not match 'csil.*\.sfu\.ca'."
  echo "This does not appear to be a CSIL machine."
  echo "This script will only run on CSIL machines."
  exit 1
fi

# CHECK 2: is the required directory in the current directory?
if [[ ! -d ${c756dir} ]]
then
  echo "There is no directory '${c756dir}' in the current directory."
  echo "Nothing for this script to delete."
  exit 2
fi

# CHECK 3: What uncommitted files, if any, are in the to-be-deleted directory?
echo "This script will remove the entire directory '${c756dir}' from your CSIL home directory."
echo
echo "The following files have been modified but not committed---they will be deleted."
echo "(an empty list indicates no modified files):"
(cd ${c756dir}; git status -s)

echo
echo -n "Have you copied all modified files back to your own machine? [y/n]: "
read ans
if [[ "${ans:0:1}" != 'y' ]]
then
  echo
  echo "Cancelling deletion."
  exit 3
fi

# CHECK 4: Give user a last chance to turn back
echo
echo -n "Do you want to delete the entire '${c756dir}' directory? [y/n]: "
read ans
if [[ "${ans:0:1}" != 'y' ]]
then
  echo
  echo "Cancelling deletion."
  exit 4
fi

# We've done as much due diligence as possible!
echo
echo "Deleting ${c756dir} ..."
/bin/rm -Rf ${c756dir}
