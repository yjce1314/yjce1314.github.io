#!/bin/bash
cd /root/587888/
rm -rf msg.txt

config=$(cat config.json)
token=$(cat token.txt)
notice=$( echo $config | jq '.notice' | sed 's/\"//g' )

text=$(curl -X POST -H "authorization:$token" -s "http://tiantang.mogencloud.com/web/api/account/message/loading")
errCode=$(echo $text | jq '.errCode' )
if [ $errCode != 0 ];then
	desp="甜糖token失效，请重新运行脚本部署一键领取程序更新token!"
else
	curl -X POST -H "authorization:$token" -s http://tiantang.mogencloud.com/web/api/account/sign_in
	text=$(curl -X POST -H "authorization:$token" -s http://tiantang.mogencloud.com/api/v3/score_logs/all_collected)
	promoteScore=$( echo $text | jq '.data.promote_score' )
	score=$( echo $text | jq '.data.score' )
	if [[ $notice = 1 ]];then
		echo "***" >> msg.txt
		echo "*今日设备星愿："$score >> msg.txt
		echo >> msg.txt
		echo >> msg.txt
		echo "*今日推广星愿："$promoteScore >> msg.txt
		echo >> msg.txt
		echo >> msg.txt
		echo "***" >> msg.txt
		echo "甜糖APP-我的-填写推荐码、填入推荐码 587888 免费获取15张星愿加速卡！" >> msg.txt
		desp=$(cat msg.txt)
	elif [[ $notice = 2 ]];then
		desp=$devdesp"------------------------------------\n今日设备心愿:"$score"\n今日推广星愿："$promoteScore"\n------------------------------------\n甜糖APP-我的-填写推荐码、填入推荐码 587888 免费获取15张星愿加速卡！"
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