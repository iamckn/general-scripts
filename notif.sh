
#!/bin/bash

inotifywait -mr ~/tmp/amr -e create -e moved_to |
        while read path action file; do
                if [[ ${file} =~ \.amr$ ]]; then
			converted=`echo $path | cut -d "/" -f 6-`
			mkdir -p ~/tmp/mp3/${converted}
			rawfile=`echo ${path}${file}`
			ffmpeg -y -i $rawfile ~/tmp/mp3/${converted}/${file}.mp3 
		fi
        done
