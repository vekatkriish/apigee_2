#!/bin/bash

if [[ "$(git ls-remote --heads $1 $2 | wc -l)" == "1" ]]
then
  git checkout $3
  git merge $2 -m "feature branch $2 merged"
  if [[ "$(git push https://$4:$5@$6 $7 --porcelain)" == *"Done"* ]]
	then
	  echo "ok"
	else
		echo "error"
	fi
else
  echo "error"
fi