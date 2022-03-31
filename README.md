# Continous Integration Continous Delivery

This is a React Node Postgres App with Continious Deployment and Continues Delivery to AWS EC2

# To Run

open terminal 1
cd server/
npm install
npm run dev

Open terminal 2
cd client/
npm install
npm start

# Setup AWS

Step 1 setup appspec file and MODIFY ACCORDINGLY
Step 2 create git repo (dont push)
Step 3 create AmazonCe2RoleforAWSCodeDeploy for EC2
Step 4 create AWScodeDeployRole for Code Deploy
Step 5 create key pair
Step 6 create EC2 ubuntu & configure ports for ssh, http, https, custom (3001) and add scripts below

#!/bin/bash
sudo dpkg --purge codedeploy-agent
sudo rm -rf /opt/codedeploy-agent
sudo apt update
sudo apt install -y ruby-full
sudo apt install -y wget
cd /home/ubuntu
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto > /tmp/logfile

Step 7 give permissions to pem by running
chmod 400 /<direcotry>/<nodeapi>.pem

Step 8 login in ec2 by running
ssh -i /<direcotry>/<nodeapi>.pem ubuntu@<EC2 IP>

Step 9 test if code deploy is added to server by running
sudo service codedeploy-agent status

Step 10 setup Code deploy
Step 11 create Deployment Application
Step 12 create Deployment group, choose AWScodeDeployRole
Step 13 create Pipeline
Step 14 create github connection

Step 15 git push code from local

Step 16 Setup Postgres by running
sudo apt update && sudo apt upgrade -y
sudo apt install postgresql postgresql-contrib -y
sudo -i -u postgres

Step 17 create ubunut user by running
createuser --interactive
ubuntu
y
sudo -i -u postgres
psql
ALTER USER ubuntu PASSWORD 'password';

Step 18 dump dev db to directory by running
pg_dump -U postgres -f <file>.pgsql -C <db>

Step 19 modify the data specificially the role owner and copy dumped data over by running
scp -i /<direcotry>/.pem <file>.pgsql ubuntu@<EC2 IP>:/home/ubuntu/

Step 20 mually create db by running
psql -d postgres
create database prod_db;

psql prod_db < /home/ubuntu/<file>.pgsql

Step 21 run build for front end (this will be donw by github Actions) by running
npm run build

Step 22 run nginx script to setup
cd ~
sudo nano /etc/nginx/sites-enabled/default

# Paset this into default

# or

server {
listen 80 default_server;
listen [::]:80 default_server;

         root /home/ubuntu/express-app/client/build;

        # Add index.php to the list if you are using PHP
        index index.html index.htm index.nginx-debian.html;

        server_name localhost;

        location / {
                try_files $uri /index.html;
        }

         location /api {
            proxy_pass http://localhost:3001;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }

}

Step 23 check syntax by running
sudo nginx -t

Step 24 restart nginx by running
sudo service nginx restart

Step 25 configure DNS

Step 26 Setup Environment Variables by running
cd ~
touch .env
nano .env

Step 27 paste envs and set by running
set -o allexport; source .env; set +o allexport;

Step 28 set env to reload on reboot by running
nano .profile

Step 29 add to bottom
set -o allexport; source /home/ubuntu/.env; set +o allexport

Step 30 Exit server and reconnect
sudo reboot

Step 31 setup firewall on ubuntu by running
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw enable -y
