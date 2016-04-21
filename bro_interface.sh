echo "Current interface you are monitoring"
current=`grep -m 1 "interface=" /opt/nsm/bro/etc/node.cfg | cut -d '=' -f 2`
echo "$current"
echo "Enter new interface"
read new
echo "Updating interface..."
sed -e "0,/$current/s//$new/" /opt/nsm/bro/etc/node.cfg
echo "Done!"
echo "Starting Bro..."
cd /opt/nsm/bro/bin
./broctl stop
./broctl deploy
cd
echo "Done!"




