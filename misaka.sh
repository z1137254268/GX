#!/bin/bash

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
PLAIN='\033[0m'

red() {
    echo -e "\033[31m\033[01m$1\033[0m"
}

green() {
    echo -e "\033[32m\033[01m$1\033[0m"
}

yellow() {
    echo -e "\033[33m\033[01m$1\033[0m"
}

clear
echo "#############################################################"
echo -e "#                 ${RED} Goorm Xray 一键安装脚本${PLAIN}                  #"
echo -e "# ${GREEN}作者${PLAIN}: Misaka No                                           #"
echo -e "# ${GREEN}网址${PLAIN}: https://owo.misaka.rest                             #"
echo -e "# ${GREEN}论坛${PLAIN}: https://vpsgo.co                                    #"
echo -e "# ${GREEN}TG群${PLAIN}: https://t.me/misakanetcn                            #"
echo "#############################################################"
echo ""

yellow "使用前请注意："
red "1. 我已知悉本项目有可能触发 Goorm 封号机制"
red "2. 我不保证脚本其搭建节点的稳定性"
read -rp "是否安装脚本？ [Y/N]：" yesno

if [[ $yesno =~ "Y"|"y" ]]; then
    rm -f railgun kazari.json
    yellow "开始安装..."
    wget -N https://raw.githubusercontent.com/z1137254268/GX/master/railgun
    chmod +x railgun
    read -rp "请设置UUID（如无设置则使用脚本默认的）：" uuid
    if [[ -z $uuid ]]; then
        uuid="10974d1a-cbd6-4b6f-db1d-38d78b3fb109"
    fi
    cat <<EOF > kazari.json
{
    "log": {
        "loglevel": "warning"
    },
    "inbounds": [
        {
            "port": 27,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "$uuid"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none"
            }
        },
        {
            "port": 27,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$uuid"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF
    nohup ./railgun -config=kazari.json &>/dev/null &
    green "Goorm Xray 已安装完成！"
    yellow "请认真阅读项目说明文档，配置端口转发！"
    yellow "别忘记给项目点一个免费的Star！"
else
    red "已取消安装，脚本退出！"
    exit 1
fi
