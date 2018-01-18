exists=`git show-ref refs/heads/$1`
if [ -n "$exists" ]
then
	git branch --delete $1
    echo true
else
    echo false
fi
