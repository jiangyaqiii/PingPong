#获取运行文件
read -p "请输入你的小狐狸密钥: " secret_key
./PINGPONG config set --0g=$secret_key
./PINGPONG stop --depins=0g
./PINGPONG start --depins=0g
rm -f start_0g.sh
