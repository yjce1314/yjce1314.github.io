#!/bin/sh
cd /root/587888/
config=$(cat config.json)
version1=$( echo $config | jq '.version' )
version2=$(curl https://dachui.co/ttnode/config.json | jq '.version')
if [ $version1 != $version2 ];then
	rm -f withdraw.sh 587888.sh node.sh
	wget https://dachui.co/ttnode/node2.sh 
	wget https://dachui.co/ttnode/withdraw.sh
	wget https://dachui.co/ttnode/587888.sh
	chmod -R 777 *
	config=$( echo $config | jq ".version=$version2" )
	echo $config > config.json
fi
