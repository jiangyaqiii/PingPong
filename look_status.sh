#!/bin/bash

if screen -ls | grep -q "pingpong"; then
    echo "pingpong 正在运行"
else
    echo "停止"
fi
