#!/bin/bash
#using case statement $1 = task_defining(merg or create)
#$2=giturl $3 =username $4 = password $5 = reponame $6 =branch1(frombranch/branchto be created) $7 = branch2(targetbranch)

GITUNM="$(echo $3 | base64 --decode)"
GITPWD="$(echo $4 | base64 --decode)"
echo "${GITUNM}"
echo "${GITPWD}"

case "$1" in
	'clone')
		git clone https://${GITUNM}:${GITPWD}@$5
		;;
	'merge')
		#$1 = giturl $2 = branch $3 = branchtobemerged $4 = gitrepo 
		if [[ "$(git ls-remote --heads $2 $6 | wc -l)" == *"1"* ]]
		then
		  echo "checkout to $7...."
		  git checkout $7
		  git merge origin/$6 -m 'feature branch $6 merged'
		  echo "branch $6 merged to $7.."
		  
		  echo "pushing the branch to remote repository...."

		  if [[ "$(git push https://${GITUNM}:${GITPWD}@$5 $7 --porcelain)" == *"Done"* ]]
		  then
		  	echo "Merging $6 with $7 was done and pushed successfully"
		  else
				echo "error pushing branch to repository"
		    exit 1
		  fi
		else
		  echo "Feature branch $6 doesnt exist to merge with $7"
		  exit 1
		fi
		;;
	'createBranch')
			# $1 = url $2 = branch1 $3 = repo 
		if [[ "$(git ls-remote --heads $2 $6 | wc -l)" == *"1"* ]]
		then
		  echo "Branch already exists in remote repository"
		  exit 1
		else
			echo "git is checking for local branch is exits or not...."
			
		  if [ -n "`git show-ref refs/heads/$6`" ]
			then
				git branch --delete $6
		    	echo "local branch is deleted and trying to create a branch in the task...."
			else
		    	echo "local git branch does'nt exists"	
		  fi
		  echo "New branch is creating...."
		  git branch $6
		  echo "New Branch $6 is created..."

		  echo "pushing the branch to remote repository...."
		    
		  if [[ "$(git push https://${GITUNM}:${GITPWD}@$5 $6 --porcelain)" == *"Done"* ]]
		  then
		      echo "Branch $6 was created and pushed successfully"
		  else
		    echo "error pushing branch to repository"
		    exit 1
		  fi
		fi
		;;
	*)
		echo "error no task is defined in CA Task please check the task syntax...."
		exit 1
		;;
  esac