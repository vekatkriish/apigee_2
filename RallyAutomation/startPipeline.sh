echo $1 $2 $3 $4 $5

curl -X POST $1  --user $2   --data-urlencode json='{"parameter": [{"name":"branchName", "value":"'$3'"}, {"name":"notes", "value":"'$4'"}, {"name":"fmtId", "value":"'$5'"}]}'