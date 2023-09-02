#!/usr/bin/env bash

#
# This removes CRLF line endings on the script files so it's compatible with the awk on Linux
#

sed -i .orig 's///g' "${DIRNAME}/configure"
sed -i .orig 's///g' "${DIRNAME}/missing"
sed -i .orig 's///g' "${DIRNAME}/config.sub"
sed -i .orig 's///g' "${DIRNAME}/config.guess"
find "${DIRNAME}" -type f -exec sed -i .orig 's///' "{}" \;
find "${DIRNAME}" -type f -exec sed -i .orig 's/\r$//' "{}" \;
