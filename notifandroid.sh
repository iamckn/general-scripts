#!/system/bin/sh

/data/local/tmp/inotifywait -mr /data/local/tmp -e create -e moved_to |
        while read path action file; do
                echo $file >> /sdcard/exfil/notified.txt
                cp $file /sdcard/exfil/
        done
