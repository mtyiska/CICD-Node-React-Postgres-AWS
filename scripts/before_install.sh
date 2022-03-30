#!/bin/bash

#download node and npm Using Ubuntu
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

# install pm2
sudo npm install -y pm2@latest -g

#create our working directory if it doesnt exist
DIR="/home/ubuntu/express-app"
if [ -d "$DIR" ]; then
  echo "${DIR} exists"
else
  echo "Creating ${DIR} directory"
  mkdir ${DIR}
fi
