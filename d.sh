#/bin/bash
for fil in ~/tmp/amr/*;
do
	#echo $fil
	ourpath=`echo $fil| cut -d "/" -f 6`
	mkdir -p ~/mp3/$ourpath/recordings
	for line in ${fil}/recordings/*;
	do	
		converted=`echo $line | cut -d "/" -f 8`
		ffmpeg -y -i $line ~/mp3/${ourpath}/recordings/${converted}.mp3
	done
done
