#!/bin/bash

# 检查是否以root用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以root用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。"
    exit 1
fi

# 节点安装功能

# 更新系统包列表
sudo apt update
apt install screen -y
sudo apt install docker.io docker-compose -y

#####检查久的客户端是否存在，如果存在，则删除#####
cd ~
screen -X -S pingpong quit
if [ -f "./PINGPONG" ]; then
    rm -f PINGPONG
    echo "已删除旧客户端"
else
    echo "不存在客户端"
fi
########################################

# 检查 Docker 是否已安装
if ! command -v docker &> /dev/null
then
    # 如果 Docker 未安装，则进行安装
    echo "未检测到 Docker，正在安装..."
    sudo apt-get install ca-certificates curl gnupg lsb-release

    # # 添加 Docker 官方 GPG 密钥
    #  sudo mkdir -p /etc/apt/keyrings
    #  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    
    # # # 设置 Docker 仓库
    # echo \
    #   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    #   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # 授权 Docker 文件
    # sudo chmod a+r /etc/apt/keyrings/docker.gpg
    # sudo apt-get update

    # # 安装 Docker 最新版本
    # sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
    sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt install docker-ce docker-ce-cli containerd.io
else
    echo "Docker 已安装。"
fi

# 下载PINGPONG程序
wget -O PINGPONG https://pingpong-build.s3.ap-southeast-1.amazonaws.com/linux/latest/PINGPONG

#获取运行文件
read -p "请输入你的设备密钥: " your_device_id
keyid="$your_device_id"

if [ -f "./PINGPONG" ]; then
    chmod +x ./PINGPONG
    screen -dmS pingpong bash -c "./PINGPONG --key \"$keyid\""
else
    echo "下载PINGPONG失败，请检查网络连接或URL是否正确。"
fi

echo "节点已经启动，请使用screen -r pingpong 查看日志"
rm -f start.sh
