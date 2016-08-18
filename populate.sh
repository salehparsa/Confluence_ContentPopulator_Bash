#!/bin/bash
echo What is your Confluence URL?
read URL
URLregex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
echo Please Enter Confluence User Name:
read username
echo Please Enter your password:
unset password;
while IFS= read -r -s -n1 pass; do
  if [[ -z $pass ]]; then
     echo
     break
  else
     echo -n '*'
     password+=$pass
  fi
done
while [[ ! $number =~ ^[0-9]+$ ]]; do
  echo Hello $username, how many pages do you want?
  read number
done
echo $username, what is your preference page prefix?
read page_title
for (( i = 0; i < $number; i++ )); do
	curl -u $username:$password -X POST -H 'Content-Type: application/json' -d'{"type":"page","title":"'$page_title'_'$i'","space":{"key":"SAL"},"body":{"storage":{"value":"<p>This is a new page</p>","representation":"storage"}}}' $URL/rest/api/content/ | python -mjson.tool
done

echo "Done"

