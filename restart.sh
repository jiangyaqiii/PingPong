screen -X -S pingpong quit
read -p "请输入你的key device id: " device_id
keyid=$device_id
screen -dmS pingpong bash -c "./PINGPONG --key \"$keyid\""
