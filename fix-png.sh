#!/usr/bin/env bash

#
# This removes CRLF line endings on the script files so it's compatible with the awk on Linux
#

sed -i 's///g' "${DIRNAME}/configure"
sed -i 's///g' "${DIRNAME}/missing"
sed -i 's///g' "${DIRNAME}/config.sub"
sed -i 's///g' "${DIRNAME}/config.guess"
find "${DIRNAME}" -type f -exec sed -i 's///' "{}" \;
find "${DIRNAME}" -type f -exec sed -i 's/\r$//' "{}" \;
