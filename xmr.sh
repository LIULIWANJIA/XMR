#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH


restartxmr(){
    echo -e "终止 XMR"
    systemctl stop c3pool_miner.service
    echo -e "XMR 已关闭"
    echo -e " "
    echo -e "尝试重新启动 XMR"
    sleep 3s
    systemctl restart c3pool_miner.service
	echo -e " "
    echo -e "XMR 重新启动 完成"
}
stopxmr(){
    echo -e "终止 XMR"
    systemctl stop c3pool_miner.service
    clearsys
    echo -e "XMR 已关闭"
}


echo -e "配置 环境 - Configuration environment"
yum install net-tools -y
yum install psmisc -y
apt-get install psmisc -y
clear
echo -e " "
echo -e " "
echo -e "XMR一键便捷脚本 默认配置70%基准CPU"
echo -e " "
echo -e " "
read -p "填写你的XMR钱包地址(默认 MineXMR):" xmrwal
[ -z "${xmrwal}" ] && xmrwal=48hfPjruh5yb16ogxaHrnhf8dunTRyEfGLxrqM4ELCdobGJaEid8K3WCWTLjUw89wt2WSyKKqU9CbQZBH6iB3FHz9UxogCm

echo -e "开始 安装 XMR - Start installing XmR"
curl -s -L http://download.c3pool.com/xmrig_setup/raw/master/setup_c3pool_miner.sh | LC_ALL=en_US.UTF-8 bash -s ${xmrwal}
echo -e "XMR 基础配置 - XmR basic configuration"
stopxmr
#设置备用矿池地址
#sed -i 's/"url": *[^,]*,/"url": "mine.c3pool.cn:17777",/' $HOME/c3pool/config.json
#sed -i 's/"url": *[^,]*,/"url": "mine.c3pool.cn:17777",/' $HOME/c3pool/config_background.json
clear
echo -e "XMR 重启 - XMR restart"
restartxmr
sleep 1s

echo -e "设置 70% CPU 基准"
sed -i 's/"max-threads-hint": *[^,]*,/"max-threads-hint": 70,/' $HOME/c3pool/config.json
sed -i 's/"max-threads-hint": *[^,]*,/"max-threads-hint": 70,/' $HOME/c3pool/config_background.json
echo -e "重新启动 XMR"
restartxmr
