#!/bin/bash

if [[ "$(git ls-remote --heads $1 $2 | wc -l)" == "1" ]]
then
  git checkout $3
  git merge $2 -m "feature branch "'$2'" merged"
  echo "OK"
else
  echo "error"
fi