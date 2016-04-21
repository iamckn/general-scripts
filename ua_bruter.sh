#!/bin/bash

while true; do
	while read -r line; do
		`curl --header "X-Forwarded-For: $line" -A "Mozilla/5.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0; Acoo Browser 1.98.744; .NET CLR 3.5.30729)" "http://45.55.68.229/index.php"`
	done < "file.txt"
done

