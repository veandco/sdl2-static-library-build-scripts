#!/usr/bin/env bash

#
# This removes CRLF line endings on the script files so it's compatible with the awk on Linux
#

sed -i .orig 's/
sed -i .orig 's/
sed -i .orig 's/
sed -i .orig 's/
find "${DIRNAME}" -type f -exec sed -i .orig 's/
find "${DIRNAME}" -type f -exec sed -i .orig 's/\r$//' "{}" \;