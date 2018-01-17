#!/bin/bash

if [[ "$(git push https://$1:$2@$3 $4 --porcelain)" == *"Done"* ]]
then
  echo "OK"
else
	echo "error"
	exit 1
fi
