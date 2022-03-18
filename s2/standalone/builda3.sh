#!/usr/bin/env bash
# Build the service with the code for A3
# Note: do not use this in the actual A3.
# That assignment requests students to use the
# actual docker calls to build the container.
#
# This script is used in ci-a3.yml.
make VER=v0.75 ASSIGN=a3 build-s2
