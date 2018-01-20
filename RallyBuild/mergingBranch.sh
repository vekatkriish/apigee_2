#!/bin/bash
# $1 = giturl; $2 = frombranch ;$3 = tobranch;$4 = username;$5 = password;$6 = gitrepo

if [[ "$(git ls-remote --heads $1 $2 | wc -l)" == *"1"* ]]
then
  echo "checkout to $3...."
  git checkout $3
  git merge $2 -m 'feature branch $1 merged'
  echo "branch $2 merged to $3.."
  
  echo "pushing the branch to remote repository...."

  	if [[ "$(git push https://$4:$5@$6 $3 --porcelain)" == *"Done"* ]]
  	then
  		echo "ok"
    else
		echo "error"
  	fi
else
  echo "error"
fi