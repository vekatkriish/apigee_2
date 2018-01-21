#!/bin/bash
# $1 = giturl; $2 = branch;$3 = username;$4 = password;$5 = git_repo

if [[ "$(git ls-remote --heads $1 $2 | wc -l)" == *"1"* ]]
then
  echo "Branch already exists in remote repository"
  exit 1
else
	echo "git is checking for local branch is exits or not...."
	
	#exists =`git show-ref refs/heads/$2`
  if [ -n "`git show-ref refs/heads/$2`" ]
	then
		  git branch --delete $2
    	echo "local branch is deleted and trying to create a branch in the task...."
	else
    	echo "local git branch does'nt exists"	
  fi
  echo "New branch is creating...."
  git branch $2
  echo "New Branch $2 is created..."

  echo "pushing the branch to remote repository...."
    
  if [[ "$(git push https://$3:$4@$5 $2 --porcelain)" == *"Done"* ]]
  then
      echo "Branch $2 was created and pushed successfully"
  else
    echo "error pushing branch to repository"
    exit 1
  fi
fi