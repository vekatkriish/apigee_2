#!/bin/bash

if [[ "$(git ls-remote --heads $1 | wc -l)" == *"1"* ]]
then
  git checkout $2
  git merge $1 -m 'feature branch $1 merged'
  echo "OK"
else
  echo "error"
fi