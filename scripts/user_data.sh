#!/bin/bash
# Descriptoin:  Install Httpd server
# Author: Omda
# Issue of date: 26-06-2025
# Modify of date: 26-06-2025


sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd.service
sudo systemctl enable httpd.service

## Install codedeploy agent
sudo yum install ruby -y
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
sudo chmod +x install
sudo ./install auto
sudo systemctl start codedeploy-agent.service