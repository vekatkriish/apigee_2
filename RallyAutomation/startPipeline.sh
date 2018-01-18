echo $1 $2 $3 $4 $5 $6

curl -X POST $1  --user $2   --data-urlencode json='{"parameter": [{"name":"notes", "value":"'$3'"}, {"name":"fmtId", "value":"'$4'"}, {"name":"branch1", "value":"'$5'"}, {"name":"branch2", "value":"'$6'"}]}'
