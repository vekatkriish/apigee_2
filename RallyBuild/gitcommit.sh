#!/bin/bash

if [[ "$(git push https://$1:$2@$3 --porcelain)" == *"Done"* ]]
then
  echo "OK"
else
	echo "error"
fi
