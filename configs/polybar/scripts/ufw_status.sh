#!/bin/bash

STATUS=$(sudo ufw status | grep -i "Status: active")

if [ -n "$STATUS" ]; then
    echo " ON"
else
    echo " OFF"
fi
