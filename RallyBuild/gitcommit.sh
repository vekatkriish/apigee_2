#!/bin/bash

if [[ "$(git push https://$1:$2@$3 $4 $5 --porcelain)" == *"Done"* ]]
then
  echo "OK"
else
	echo "error"
fi
