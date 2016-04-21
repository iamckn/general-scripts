#!/bin/bash

grep -E 'os.*id+' test.txt | cut -d "|" -f 2 | cut -d "=" -f 2 | grep -v 192.168.0.114 > sessions.txt

while read -r line; do
	IP=`echo $line | cut -f 1 -d "/"`
	TIME=`grep "$line.*id+" test.txt | cut -d "|" -f 1 | cut -d " " -f -2`
	OS=`grep -E "$line.*os.*id+" test.txt | cut -d "=" -f 6 | cut -f 1 -d "|"`
	BROWSER=`grep -E "$line.*User-Agent" test.txt | cut -d "|" -f 5 |cut -d "=" -f 2`
	AGENT=`grep -E "$line.*User-Agent" test.txt | cut -d ":" -f 6-`
	LINK=`grep -E "$line.*subj=cli.*mtu" test.txt | cut -d "|" -f 5 | cut -d "=" -f 2`

	`curl --user-agent "Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)" --silent http://whatismyipaddress.com/ip/$IP > ip_lookup.txt`
	LOCATION=`cat ip_lookup.txt | grep "&nbsp;&nbsp" | cut -d "&" -f 1 | paste - - -d,`
	DESCRIPTION=`cat ip_lookup.txt | grep "description" | cut -d '"' -f 4 | cut -d "." --complement -f 5-`
	TYPE=`cat ip_lookup.txt | grep "Type:<" |cut -d ":" -f 14 | cut -d ">" -f 4 | cut -d "<" -f 1`
	`echo $line >> output.txt`
	`echo -e "Time\t\t" "$TIME" >> output.txt`
	`echo -e "OS\t\t" "$OS" >> output.txt`
	`echo -e "Browser\t\t" "$BROWSER" >> output.txt`
	`echo -e "Agent\t\t" "$AGENT" >> output.txt`
	`echo -e "Link\t\t" "$LINK" >> output.txt`
	`echo -e "Location\t" "$LOCATION" >> output.txt`
	`echo -e "Type\t\t" "$TYPE" >> output.txt`
	`echo -e "Description\t" "$DESCRIPTION\n" >> output.txt`
done < "sessions.txt"

exit 0
