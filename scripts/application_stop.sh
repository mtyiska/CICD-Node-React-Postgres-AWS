#!/bin/bash
if [ ! $(hash pm2 2>/dev/null) ]; then
    echo "pm2 not installed"
else
    echo "pm2 is installed"
    pm2 stop app
fi