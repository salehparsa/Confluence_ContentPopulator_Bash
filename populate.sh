#!/bin/bash
echo What is your Confluence URL?
read URL
echo username:
read username
echo password:
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
echo Hello $username How many pages do you want?
read number
echo What is page prefex?
read page_title
for (( i = 0; i < $number; i++ )); do
	curl -u $username:$password -X POST -H 'Content-Type: application/json' -d'{"type":"page","title":"'$page_title'_'$i'","space":{"key":"SAL"},"body":{"storage":{"value":"<p>This is a new page</p>","representation":"storage"}}}' $URL/rest/api/content/ | python -mjson.tool
done

echo "Done"
