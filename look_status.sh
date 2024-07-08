#!/bin/bash

if screen -ls | grep -q "pingpong"; then
    echo "pingpong 正在运行"
else
    echo "未在运行"
fi
