#!/bin/sh
clear
function menu ()
{
    cat << EOF

#######  #####  #######  #####   #####   #####  
#       #     # #    #  #     # #     # #     # 
#       #     #     #   #     # #     # #     # 
######   #####     #     #####   #####   #####  
      # #     #   #     #     # #     # #     # 
#     # #     #   #     #     # #     # #     # 
 #####   #####    #      #####   #####   #####                                                

==============================================
    填写邀请码：587888  免费获取15张加成卡！
==============================================
玩客云刷armbian视频教程：https://post.smzdm.com/p/awx4rqkk/

`echo -e "\033[35m 1)32位设备安装（玩客云）\033[0m"`
`echo -e "\033[35m 2)64位设备安装（斐讯N1）\033[0m"`
`echo -e "\033[35m 3)更换Mac地址\033[0m"`
`echo -e "\033[35m 4)卸载甜糖\033[0m"`
`echo -e "\033[35m 5)退出\033[0m"`
EOF
read -p "请确认操作：" num
case $num in
    1)
		read -p '欢迎使用32位armbian甜糖CDN自动部署程序
		                                       
		==============================================
		    填写邀请码：587888  免费获取15张加成卡！
		==============================================
		
		请输入邀请码 587888 开始自动部署：' number
		 
		if [ $number = 587888 ];then
			echo "输入正确，开始部署！"         
			cp -pdr /etc/rc.local /etc/rc.local.default
			cp -pdr /etc/crontab /etc/crontab.default
			rm -rf /etc/network/interfaces
			cp -pdr /etc/network/interfaces /etc/network/interfaces.default
			
			rm -rf /mnts
			mkdir /mnts
			fdisk -l
			read -p "tips：建议看容量挂载，或者填入【 LABEL="587888" 】并把磁盘名改为【 587888 】
			请填入要挂载的分区，例如/dev/sda1:" fenqu
			mount $fenqu /mnts/
		
			rm -rf /usr/node
			mkdir /usr/node
			cd /usr/node/
			
			wget https://dachui.co/ttnode/ttnode32 -O ttnode
			wget https://dachui.co/ttnode/crash_monitor.sh
			wget https://dachui.co/ttnode/log.log
			chmod -R 777 *
			
			sed -i "12a mount $fenqu /mnts/\nservice sshd start\n/usr/node/ttnode -p /mnts" /etc/rc.local
			
			mac=00:60:2F$(dd bs=1 count=3 if=/dev/random 2>/dev/null |hexdump -v -e '/1 ":%02X"')
			
			sed -i "6a hwaddress $mac" /etc/network/interfaces
			
			sed -i '14a */1 * * * *	root	/usr/node/crash_monitor.sh' /etc/crontab
			clear
			echo "
			--------------------------------------------------------------------------------------------------
			
			部署成功，请输入命令：reboot 重启！
			/etc/rc.local、/etc/crontab 文件都有备份到同目录加后缀.default
			bug反馈链接：https://www.right.com.cn/forum/forum.php?mod=viewthread&tid=4057372
			
			===================================================
			===================================================
			      请大力填写我的甜糖发财邀请码：587888
			===================================================
			===================================================
			
			此脚本由「折了个腾」原创发布，没有shell开发经验，现学现卖写的
			
			开发不易，新来的朋友填我的推荐码 587888 支持一下，感谢！
			
			--------------------------------------------------------------------------------------------------
			"
		
		else
			echo "输入有误！我的邀请码是：587888"
		fi
      ;;
    2)
		read -p '欢迎使用64位armbian甜糖CDN自动部署程序
		                                       
		==============================================
		    填写邀请码：587888  免费获取15张加成卡！
		==============================================
		
		请输入邀请码 587888 开始自动部署：' number
		 
		if [ $number = 587888 ];then
			echo "输入正确，开始部署！"         
			cp -pdr /etc/rc.local /etc/rc.local.default
			cp -pdr /etc/crontab /etc/crontab.default
			rm -rf /etc/network/interfaces
			cp -pdr /etc/network/interfaces /etc/network/interfaces.default
			
			rm -rf /mnts
			mkdir /mnts
			fdisk -l
			read -p "tips：建议看容量挂载，或者填入【 LABEL="587888" 】并把磁盘名改为【 587888 】
			请填入要挂载的分区，例如/dev/sda1:" fenqu
			mount $fenqu /mnts/
		
			rm -rf /usr/node
			mkdir /usr/node
			cd /usr/node/
			
			wget https://dachui.co/ttnode/ttnode64 -O ttnode
			wget https://dachui.co/ttnode/crash_monitor.sh
			wget https://dachui.co/ttnode/log.log
			chmod -R 777 *
			
			sed -i "12a mount $fenqu /mnts/\nservice sshd start\n/usr/node/ttnode -p /mnts" /etc/rc.local
			
			mac=00:60:2F$(dd bs=1 count=3 if=/dev/random 2>/dev/null |hexdump -v -e '/1 ":%02X"')
			
			sed -i "6a hwaddress $mac" /etc/network/interfaces
			
			sed -i '14a */1 * * * *	root	/usr/node/crash_monitor.sh' /etc/crontab
			clear
			echo "
			--------------------------------------------------------------------------------------------------
			
			部署成功，请输入命令：reboot 重启！
			/etc/rc.local、/etc/crontab 文件都有备份到同目录加后缀.default
			bug反馈链接：https://www.right.com.cn/forum/forum.php?mod=viewthread&tid=4057372
			
			===================================================
			===================================================
			      请大力填写我的甜糖发财邀请码：587888
			===================================================
			===================================================
			
			此脚本由「折了个腾」原创发布，没有shell开发经验，现学现卖写的
			
			开发不易，新来的朋友填我的推荐码 587888 支持一下，感谢！
			
			--------------------------------------------------------------------------------------------------
			"
		
		else
			echo "输入有误！我的邀请码是：587888"
		fi
      
      ;;
    3)
	rm -rf /etc/network/interfaces
	cp -pdr /etc/network/interfaces.default /etc/network/interfaces
	mac=00:60:2F$(dd bs=1 count=3 if=/dev/random 2>/dev/null |hexdump -v -e '/1 ":%02X"')
	sed -i "6a hwaddress $mac" /etc/network/interfaces
	echo "修改Mac成功，新Mac是：$mac 请重新绑定设备！
	3秒后返回主菜单..."
	sleep 3s
	menu
	;;
    4)
	rm -rf /etc/rc.local
	rm -rf /etc/crontab
	rm -rf /etc/network/interfaces
	rm -rf /mnts
	rm -rf /usr/node
	
	cp -pdr /etc/rc.local.default /etc/rc.local
	cp -pdr /etc/crontab.default /etc/crontab
	cp -pdr /etc/network/interfaces.default /etc/network/interfaces
	
	echo "卸载甜糖成功！
	3秒后返回主菜单..."
	sleep 3s
	menu
	;;
    5)
	exit 0
esac
}
menu