echo $a
screen -X -S pingpong quit
read -p "请输入你的key device id: " your_device_id
keyid="$your_device_id"
screen -dmS pingpong bash -c "./PINGPONG --key \"$keyid\""
