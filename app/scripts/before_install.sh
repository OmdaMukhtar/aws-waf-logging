#!/bin/bash
echo "Running BeforeInstall..."
echo "Installing dependancies of the application.."

yum update -y
yum install php -y
