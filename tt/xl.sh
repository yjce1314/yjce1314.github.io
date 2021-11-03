#!/bin/bash

UserAgent="Mozilla/5.0 (iPhone; CPU iPhone OS 14_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 mediaCode=SFEXPRESSAPP-iOS-ML"
cookie='JSESSIONID=16nx17r1cfirykx56j1tcwwir; sensorsdata2015jssdkcross={"distinct_id":"02FC0901CDEA4773B5E970AE04433724","first_id":"17c3c5c654c90c-0a17fc5d47c2518-3b702e36-370944-17c3c5c654d649","props":{"$latest_traffic_source_type":"直接流量","$latest_search_keyword":"未取到值_直接打开","$latest_referrer":""},"$device_id":"17c3c5c654c90c-0a17fc5d47c2518-3b702e36-370944-17c3c5c654d649"}; sessionId=16nx17r1cfirykx56j1tcwwir'
data='{"comeFrom":"vioin","channelFrom":"SFAPP"}'

text=$(curl --cookie $cookie --user-agent $UserAgent -H "Content-Type: application/json;charset=utf-8" -d $data -s "https://mcs-mimp-web.sf-express.com/mcs-mimp/commonPost/~memberActivity~integralTaskSignService~automaticSignFetchPackage")



if [ $errCode != 0 ];then
	desp="甜糖token失效，请重新运行脚本部署一键领取程序更新token!"
else	
	if [[ $notice = 1 ]];then
		echo "***" >> msg.txt
		echo "设备星愿详情：" >> msg.txt
		echo >> msg.txt
		echo >> msg.txt

		devList=$( echo $text | jq '.data.data' )
		lengthdevList=$( echo $text | jq '.data.data|length' )
		for index in `seq 0 $lengthdevList`
		do
			devId=$( echo $devList | jq ".[$index].id" | sed 's/\"//g' )
			if [ $devId != null ];then
				devAlias=$( echo $devList | jq ".[$index].alias" | sed 's/\"//g' )
				devSore=$( echo $devList | jq ".[$index].inactived_score" )

				curl -X POST -H "authorization:$token" -s http://tiantang.mogencloud.com/api/v1/score_logs?device_id=$devId\&score=$devSore
				echo $devAlias"星愿："$devSore >> msg.txt
				echo >> msg.txt
				echo >> msg.txt
			fi
			sleep 5s
		done
		curl -X POST -H "authorization:$token" -s http://tiantang.mogencloud.com/web/api/account/sign_in

		text=$(curl -X POST -H "authorization:$token" -s http://tiantang.mogencloud.com/web/api/account/message/loading)
		inactivedPromoteScore=$( echo $text | jq '.data.inactivedPromoteScore' )
		curl -X POST -H "authorization:$token" -s http://tiantang.mogencloud.com/api/v1/promote/score_logs?score=$inactivedPromoteScore

		text=$(curl -X POST -H "authorization:$token" -s http://tiantang.mogencloud.com/web/api/account/message/loading)
		promoteScore=$( echo $text | jq '.data.promoteScore' )
		score=$( echo $text | jq '.data.score' )
		add_up_score=$( echo $text | jq '.data.add_up_score' )

		echo "***" >> msg.txt
		echo "*账户总星愿："$score >> msg.txt
		echo >> msg.txt
		echo >> msg.txt
		echo "*累计星愿："$add_up_score >> msg.txt
		echo >> msg.txt
		echo >> msg.txt
		echo "*总推广星愿："$promoteScore >> msg.txt
		echo >> msg.txt
		echo >> msg.txt
		echo "*今日推广星愿："$inactivedPromoteScore >> msg.txt
		echo >> msg.txt
		echo >> msg.txt
		echo "***" >> msg.txt
		echo "甜糖APP-我的-填写推荐码、填入推荐码 587888 免费获取15张星愿加速卡！" >> msg.txt
		desp=$(cat msg.txt)
	elif [[ $notice = 2 ]];then
		devList=$( echo $text | jq '.data.data' )
		lengthdevList=$( echo $text | jq '.data.data|length' )
		devdesp="------------------------------------\n设备星愿详情：\n"
		for index in `seq 0 $lengthdevList`
		do
			devId=$( echo $devList | jq ".[$index].id" | sed 's/\"//g' )
			if [ $devId != null ];then
				devAlias=$( echo $devList | jq ".[$index].alias" | sed 's/\"//g' )
				devSore=$( echo $devList | jq ".[$index].inactived_score" )
				curl -X POST -H "authorization:$token" -s http://tiantang.mogencloud.com/api/v1/score_logs?device_id=$devId\&score=$devSore

				devdesp=$devdesp"$devAlias星愿："$devSore"\n"
			fi
			sleep 5s
		done
		curl -X POST -H "authorization:$token" -s http://tiantang.mogencloud.com/web/api/account/sign_in

		text=$(curl -X POST -H "authorization:$token" -s http://tiantang.mogencloud.com/web/api/account/message/loading)
		inactivedPromoteScore=$( echo $text | jq '.data.inactivedPromoteScore' )
		curl -X POST -H "authorization:$token" -s http://tiantang.mogencloud.com/api/v1/promote/score_logs?score=$inactivedPromoteScore

		text=$(curl -X POST -H "authorization:$token" -s http://tiantang.mogencloud.com/web/api/account/message/loading)
		promoteScore=$( echo $text | jq '.data.promoteScore' )
		score=$( echo $text | jq '.data.score' )
		add_up_score=$( echo $text | jq '.data.add_up_score' )
		desp=$devdesp"------------------------------------\n账户总星愿:"$score"\n累计星愿："$add_up_score"\n总推广星愿："$promoteScore"\n今日推广星愿："$inactivedPromoteScore"\n------------------------------------\n甜糖APP-我的-填写推荐码、填入推荐码 587888 免费获取15张星愿加速卡！"

	fi
fi

#通知 notice 1.sever酱  2.telegram
if [[ $notice = 1 ]];then
	sckey=$( echo $config | jq '.sckey'  | sed 's/\"//g' )
	curl -X POST -d "text=甜糖日报&desp=$desp" https://sc.ftqq.com/$sckey.send
elif [[ $notice = 2 ]];then
	chatId=$( echo $config | jq '.chatId'  | sed 's/\"//g')
	curl -X POST -d "{\"chatId\":\"$chatId\",\"text\":\"甜糖日报：\n$desp\"}" https://telegram.dachui.workers.dev
fi