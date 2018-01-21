#!/bin/bash
# $1 = giturl; $2 = frombranch ;$3 = tobranch;$4 = username;$5 = password;$6 = gitrepo

if [[ "$(git ls-remote --heads $1 $2 | wc -l)" == *"1"* ]]
then
  echo "checkout to $3...."
  git checkout $3
  git merge origin/$2 -m 'feature branch $1 merged'
  echo "branch $2 merged to $3.."
  
  echo "pushing the branch to remote repository...."

  if [[ "$(git push https://$4:$5@$6 $3 --porcelain)" == *"Done"* ]]
  then
  	echo "Merging $2 with $3 was pushed successfully"
  else
		echo "error pushing branch to repository"
    exit 1
  fi
else
  echo "Feature branch $2 doesnt exist to merge with $3"
  exit 1
fi