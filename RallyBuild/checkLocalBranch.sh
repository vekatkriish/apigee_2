exists=`git show-ref refs/heads/$1`
if [ -n "$exists" ]; then
    echo true
else
    echo false
fi
