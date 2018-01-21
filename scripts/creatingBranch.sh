#!/bin/bash
# $1 = giturl; $2 = branch;$3 = username;$4 = password;$5 = git_repo

GITUN="$(echo $3== | base64 --decode)"
GITPW="$(echo $4== | base64 --decode)"
if [[ "$(git ls-remote --heads $1 $2 | wc -l)" == *"1"* ]]
then
  echo "Branch already exists in remote repository"
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
  	
  	if [[ "$(git push https://${GITUN}:${GITPW}@$5 $2 --porcelain)" == *"Done"* ]]
  	then
  		echo "ok"
    else
		echo "error"
  	fi
fi