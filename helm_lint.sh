#!/bin/sh -e

DIRECTORIES=$(find . -name 'requirements.yaml' -exec dirname {} \;)

for directory in ${DIRECTORIES}
do
  echo "${directory}"
  helm dep update "${directory}"
done
