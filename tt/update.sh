#!/bin/sh
cd /root/587888/
config=$(cat config.json)
version1=$( echo $config | jq '.version' )
version2=$(curl https://dachui.co/ttnode/config.json | jq '.version')
if [ $version1 != $version2 ];then
	rm -f withdraw.sh promote.sh 587888.sh update.sh
	wget https://dachui.co/tt/587888.sh
	wget https://dachui.co/tt/withdraw.sh
	wget https://dachui.co/tt/promote.sh
	wget https://dachui.co/tt/update.sh
	chmod -R 777 *
	config=$( echo $config | jq ".version=$version2" )
	echo $config > config.json
fi
