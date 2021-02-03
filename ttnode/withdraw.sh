#!/bin/sh
token=$(cat /root/587888/token.txt)
sckey=$(cat /root/587888/sckey.txt)

text=$(curl -X POST -H "authorization:$token" -s http://tiantang.mogencloud.com/web/api/account/message/loading)

score=$( echo $text | jq '.data.score' )
real_name=$( echo $text | jq '.data.zfbList[0].name' | sed 's/\"//g')
card_id=$( echo $text | jq '.data.zfbList[0].account' | sed 's/\"//g')

t_score=$( echo ${score}/100 |bc )
t_score=`expr $t_score \* 100`

url_text="/api/v1/withdraw_logs?score="$t_score"&real_name="$real_name"&card_id="$card_id"&bank_name=支付宝&sub_bank_name=&type=zfb"

ttext=$(curl -X POST -H "authorization:$token" -s http://tiantang.mogencloud.com/$url_text)

errCode=$(echo $ttext | jq '.errCode' )
msg=$(echo $ttext | jq '.msg' | sed 's/\"//g' | sed s/[[:space:]]//g)

if [ $errCode = 0 ];then
	posttext="text=甜糖自动提现成功&desp=甜糖自动提现:"$t_score"成功！，请留意到账情况！"
else
	posttext="text=甜糖自动提现失败&desp=甜糖自动提现失败，具体原因："$msg
fi

curl -X POST -d $posttext https://sc.ftqq.com/$sckey.send

