screen -X -S pingpong quit
keyid=$device_id
screen -dmS pingpong bash -c "./PINGPONG --key \"$keyid\""
