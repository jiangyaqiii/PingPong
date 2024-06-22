screen -X -S pingpong quit
read -p "请输入你的key device id: " device_id
keyid=$device_id
screen -dmS pingpong bash -c "./PINGPONG --key \"$keyid\""
echo '已重启，请返回我的服务，点击检查状态'
cd ~
rm -f restart.sh
