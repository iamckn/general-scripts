#!/bin/bash

#touch test.txt

while read -r line; do
	EAGLE=`echo $line | grep  EagleEye`
	SENDTO=`echo $line | grep  EagleEye.*sendto`
	RECV=`echo $line | grep  EagleEye.*recvfrom`
	READ=`echo $line | grep  EagleEye.*read`
	WRITE=`echo $line | grep  EagleEye.*write`
	OPEN=`echo $line | grep  EagleEye.*open`
	DELETE=`echo $line | grep  EagleEye.*delete`
	PLAINTEXT=`echo $line | grep  EagleEye.*plaintext`

    if [ -n "$SENDTO" ]; then
    	echo SEND: >> test.txt
    	echo $SENDTO | cut -d '"' -f 28 >> test.txt
    	echo $SENDTO | cut -d '"' -f 20 | perl -pe 's/([0-9a-f]{2})/chr hex $1/gie' | sed 's/\x0//g' >> test.txt
    	echo "********************************************************************" >> test.txt

    elif [ -n "$RECV" ]; then
    	echo RECEIVE: >> test.txt
    	echo $RECV | cut -d '"' -f 28 >> test.txt
    	echo $RECV | cut -d '"' -f 20 | grep -v 6e797376 | perl -pe 's/([0-9a-f]{2})/chr hex $1/gie' | sed 's/\x0//g' >> test.txt
    	echo "********************************************************************" >> test.txt
    
    elif [ -n "$READ" ]; then
    	echo READ: >> test.txt
    	echo $READ | cut -d '"' -f 28 >> test.txt
    	echo $READ | cut -d '"' -f 20 | grep -v '"57"'| perl -pe 's/([0-9a-f]{2})/chr hex $1/gie' | sed 's/\x0//g' >> test.txt
    	echo "********************************************************************" >> test.txt

    elif [ -n "$WRITE" ]; then
    	echo WRITE: >> test.txt
    	echo $WRITE | cut -d '"' -f 28 >> test.txt
    	echo $WRITE | cut -d '"' -f 20 | grep -v '"57"' | perl -pe 's/([0-9a-f]{2})/chr hex $1/gie' | sed 's/\x0//g' >> test.txt
    	echo "********************************************************************" >> test.txt

    elif [ -n "$PLAINTEXT" ]; then
    	echo PLAINTEXT: >> test.txt
    	echo $PLAINTEXT | cut -d '"' -f 28 >> test.txt
    	echo $PLAINTEXT | cut -d '"' -f 14 | perl -pe 's/([0-9a-f]{2})/chr hex $1/gie' | sed 's/\x0//g' >> test.txt
    	echo "********************************************************************" >> test.txt

    elif [ -n "$DELETE" ]; then
    	echo DELETE: >> test.txt
    	echo $DELETE | cut -d '"' -f 16 >> test.txt
    	echo "********************************************************************" >> test.txt


    elif [ -n "$OPEN" ]; then
    	echo OPEN: >> test.txt
    	echo $OPEN | cut -d '"' -f 16 >> test.txt
    	echo "********************************************************************" >> test.txt

    elif [ -n "$EAGLE" ]; then
    	echo $line >> test.txt
    fi

done < "eagle.txt"